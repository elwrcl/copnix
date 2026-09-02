#!/usr/bin/env python3
"""
degauss-sound "thwoonngg" every time.

  degauss-sound                 # play it
  degauss-sound -o out.wav      # write a file instead
  degauss-sound --seed 42       # reproducible, for tuning
  degauss-sound --duration 1.5  # match your shader's DURATION
"""

import argparse
import array
import math
import os
import random
import subprocess
import sys
import tempfile
import wave

SR = 48000
TABLE_BITS = 12
TABLE_SIZE = 1 << TABLE_BITS
TABLE_MASK = TABLE_SIZE - 1
SINE = [math.sin(2.0 * math.pi * i / TABLE_SIZE) for i in range(TABLE_SIZE)]


def synth(duration, rng):
    n = int(SR * duration)
    out = array.array("d", bytes(8 * n))

    # randomized tube personality 
    f0 = rng.uniform(46.0, 74.0)
    glide = rng.uniform(3.0, 14.0) 
    h2 = rng.uniform(0.30, 0.60)   
    h3 = rng.uniform(0.12, 0.32)
    h4 = rng.uniform(0.00, 0.09)
    h5 = rng.uniform(0.03, 0.15)

    warble_hz = rng.uniform(5.5, 10.5)  
    warble_depth = rng.uniform(0.28, 0.55)
    wander_hz = rng.uniform(1.3, 3.4) 
    wander_depth = rng.uniform(0.4, 1.1)

    decay = rng.uniform(2.1, 3.4)
    rattle_amt = rng.uniform(0.025, 0.095)
    rattle_decay = rng.uniform(6.0, 14.0)
    thump_f = rng.uniform(33.0, 54.0)
    thump_amt = rng.uniform(0.30, 0.70)
    thump_decay = rng.uniform(11.0, 22.0)
    second_kick = rng.random() < 0.35
    kick_at = rng.uniform(0.22, 0.45)
    kick_amt = rng.uniform(0.25, 0.55)

    # phase accumulators 
    scale = TABLE_SIZE / SR
    ph = 0.0
    ph_warble = 0.0
    ph_wander = 0.0
    ph_thump = 0.0
    dt = 1.0 / SR
    inv_dur = 1.0 / duration

    peak = 0.0
    for i in range(n):
        t = i * dt
        k = t * inv_dur

        # coil tone, gliding down
        f = f0 - glide * k
        ph += f * scale
        p = int(ph)
        tone = SINE[p & TABLE_MASK]
        tone += h2 * SINE[(p << 1) & TABLE_MASK]
        tone += h3 * SINE[(p * 3) & TABLE_MASK]
        tone += h4 * SINE[(p << 2) & TABLE_MASK]
        tone += h5 * SINE[(p * 5) & TABLE_MASK]

        # warble, itself slowly wandering
        ph_wander += wander_hz * scale
        ph_warble += (warble_hz + wander_depth * SINE[int(ph_wander) & TABLE_MASK]) * scale
        warble = 1.0 - warble_depth + warble_depth * SINE[int(ph_warble) & TABLE_MASK]

        # envelope: near-instant attack, exponential decay
        env = math.exp(-decay * t) * (1.0 - math.exp(-220.0 * t))
        if second_kick:
            d = t - kick_at
            if d > 0.0:
                env += kick_amt * math.exp(-decay * 1.6 * d) * (1.0 - math.exp(-160.0 * d))

        # opening clunk
        ph_thump += thump_f * scale
        thump = thump_amt * SINE[int(ph_thump) & TABLE_MASK] * math.exp(-thump_decay * t)

        # shadow-mask rattle
        rattle = rattle_amt * (rng.random() * 2.0 - 1.0) * math.exp(-rattle_decay * t)

        s = tone * warble * env + thump + rattle
        out[i] = s
        a = s if s >= 0.0 else -s
        if a > peak:
            peak = a

    # normalize, then fade the tail so it never clicks
    gain = 0.85 / peak if peak > 0.0 else 0.0
    fade = int(SR * 0.04)
    pcm = array.array("h", bytes(2 * n))
    for i in range(n):
        s = out[i] * gain
        if i >= n - fade:
            s *= (n - i) / fade
        v = int(s * 32767.0)
        pcm[i] = 32767 if v > 32767 else (-32768 if v < -32768 else v)
    return pcm


def write_wav(path, pcm):
    with wave.open(path, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(pcm.tobytes())


def play(path, volume):
    for cmd in (["pw-play", "--volume=%s" % volume, path],
                ["paplay", path],
                ["aplay", "-q", path]):
        try:
            return subprocess.run(cmd, stderr=subprocess.DEVNULL).returncode
        except FileNotFoundError:
            continue
    print("degauss-sound: no player found (pw-play/paplay/aplay)", file=sys.stderr)
    return 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", "--out", help="write a wav here instead of playing")
    ap.add_argument("-d", "--duration", type=float, default=1.5,
                    help="seconds; match your shader's DURATION (default 1.5)")
    ap.add_argument("-s", "--seed", type=int, help="reproducible output")
    ap.add_argument("-v", "--volume", default="0.5", help="pw-play volume")
    args = ap.parse_args()

    rng = random.Random(args.seed)
    pcm = synth(args.duration, rng)

    if args.out:
        write_wav(args.out, pcm)
        return 0

    tmpdir = os.environ.get("XDG_RUNTIME_DIR") or tempfile.gettempdir()
    fd, path = tempfile.mkstemp(suffix=".wav", dir=tmpdir)
    os.close(fd)
    try:
        write_wav(path, pcm)
        return play(path, args.volume)
    finally:
        os.unlink(path)


if __name__ == "__main__":
    sys.exit(main())
