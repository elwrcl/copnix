///degauss.glsl
const float BOOT_DELAY = 0.45;
const float DURATION   = 1.0;

// how hard the coil hits.
const float WOBBLE_AMP    = 0.055;
const float WAVE_FREQ     = 9.0;
const float WAVE_SPEED    = 3.2;
const float WAVE_GLIDE    = 0.35;
const float WARBLE_HZ     = 7.0;
const float WARBLE_DEPTH  = 0.25;
const float CHROMA_AMP    = 0.016;
const float FLASH_AMP     = 0.55;
const float JITTER_AMP    = 0.006;
const float SQUEEZE_AMP   = 0.075;
const float BAND_SWEEPS   = 2.0;
const bool  JUMP_DEGAUSS = false;
const float CURSOR_JUMP  = 0.60;

#define TAU 6.28318530718
float envelope(float t) {
    if (t <= 0.0 || t >= DURATION) return 0.0;
    float k = t / DURATION;
    float attack = 1.0 - exp(-45.0 * t);
    float ring   = exp(-2.3 * k);
    float tail   = 1.0 - k * k * k * k;
    return attack * ring * tail;
}

float coilPhase(float t) {
    float k = clamp(t / DURATION, 0.0, 1.0);
    return WAVE_SPEED * t * (1.0 - 0.5 * WAVE_GLIDE * k);
}

float hash11(float x) {
    return fract(sin(x * 78.233) * 43758.5453);
}
vec4 sampleTerm(vec2 uv) {
    vec2 halfTexel = 0.5 / iResolution.xy;
    return texture(iChannel0, clamp(uv, halfTexel, 1.0 - halfTexel));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    float amp = 0.0;
    float t   = 0.0;

    float boot = iTime - BOOT_DELAY;
    float bootAmp = envelope(boot);
    if (bootAmp > amp) { amp = bootAmp; t = boot; }

    if (JUMP_DEGAUSS) {
        float jump    = abs(iCurrentCursor.y - iPreviousCursor.y);
        float elapsed = iTime - iTimeCursorChange;
        if (jump > CURSOR_JUMP * iResolution.y) {
            float e = envelope(elapsed);
            if (e > amp) { amp = e; t = elapsed; }
        }
    }

    if (amp <= 0.0001) {
        fragColor = texture(iChannel0, uv);
        return;
    }

    // coil's own tremble, so the picture pulses along with the warble in the
    // sound instead of sliding smoothly under it.
    amp *= 1.0 - WARBLE_DEPTH + WARBLE_DEPTH * sin(t * TAU * WARBLE_HZ);

    float ph = coilPhase(t);

    // magnetic distortion
    vec2 p = uv - 0.5;

    float wave  = sin(p.y * WAVE_FREQ * TAU - ph * TAU);
    float wave2 = sin(p.y * WAVE_FREQ * 2.3 * TAU + ph * 0.62 * TAU);
    float warp  = wave * 0.7 + wave2 * 0.3;

    // vertical breathing
    p.y /= 1.0 + amp * SQUEEZE_AMP * sin(t * TAU * 3.0);
    p   *= 1.0 - amp * 0.04 * sin(t * TAU * 2.0);

    // per-scanline jitter
    float line   = floor(uv.y * iResolution.y);
    float jitter = (hash11(line + floor(t * 90.0)) - 0.5) * 2.0;

    p.x += amp * (WOBBLE_AMP * warp + JITTER_AMP * jitter);

    vec2 duv = p + 0.5;

    // misconvergence
    float ca = amp * CHROMA_AMP * (0.5 + abs(warp));
    vec4 cr = sampleTerm(duv + vec2(ca, 0.0));
    vec4 cg = sampleTerm(duv);
    vec4 cb = sampleTerm(duv - vec2(ca, 0.0));

    vec4 col = vec4(cr.r, cg.g, cb.b, cg.a);

    // coil pulse sweeping down the tube
    float bandY = 1.0 - fract(t / DURATION * BAND_SWEEPS);
    float band  = exp(-pow((uv.y - bandY) * 9.0, 2.0));

    // background-opacity to solid for the length of the flash.
    float glow = amp * FLASH_AMP * (0.25 + 0.75 * band);
    col.rgb += glow * (iForegroundColor * 0.22 + col.rgb * 0.9);

    fragColor = col;
}
