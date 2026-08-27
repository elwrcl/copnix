{ ... }:
{
  flake.nixosModules.common-crashlog =
    { pkgs, ... }:
    let
      netconsole = pkgs.writeShellApplication {
        name = "netconsole-on";
        runtimeInputs = [
          pkgs.iproute2
          pkgs.kmod
        ];
        text = ''
          TARGET_DIR=/sys/kernel/config/netconsole/copland
          usage() {
            echo "usage: netconsole-on <ip> <target-mac> [interface] [port]" >&2
            echo "          netconsole-on off" >&2
            echo "" >&2
            echo "  e.g.: netconsole-on 192.168.1.10 aa:bb:cc:dd:ee:ff" >&2
            echo "  on the receiving side: nc -u -l 6666" >&2
            echo "" >&2
            echo "  target-mac: if the target is on the same network, use the target's MAC" >&2
            echo "              otherwise use the gateway's MAC (find it with ip neigh)" >&2
            exit 1
          }

          if [ "''${1:-}" = "off" ]; then
            if [ -d "$TARGET_DIR" ]; then
              echo 0 > "$TARGET_DIR/enabled" || true
              rmdir "$TARGET_DIR"
              echo "netconsole disabled"
            else
              echo "netconsole already disabled"
            fi
            exit 0
          fi

          [ "$#" -ge 2 ] || usage

          TARGET_IP="$1"
          TARGET_MAC="$2"
          IFACE="''${3:-enp8s0}"
          PORT="''${4:-6666}"

          LOCAL_IP="$(ip -4 -o addr show dev "$IFACE" | awk '{print $4}' | cut -d/ -f1 | head -1)"
          if [ -z "$LOCAL_IP" ]; then
            echo "error: no IPv4 address on $IFACE (is the cable plugged in?)" >&2
            exit 1
          fi

          modprobe netconsole
          [ -d "$TARGET_DIR" ] && { echo 0 > "$TARGET_DIR/enabled" || true; rmdir "$TARGET_DIR"; }
          mkdir -p "$TARGET_DIR"

          echo 1             > "$TARGET_DIR/extended"
          echo "$IFACE"      > "$TARGET_DIR/dev_name"
          echo "$LOCAL_IP"   > "$TARGET_DIR/local_ip"
          echo "$TARGET_IP"  > "$TARGET_DIR/remote_ip"
          echo "$TARGET_MAC" > "$TARGET_DIR/remote_mac"
          echo "$PORT"       > "$TARGET_DIR/remote_port"
          echo 1             > "$TARGET_DIR/enabled"

          echo "netconsole enabled: $IFACE ($LOCAL_IP) -> $TARGET_IP:$PORT"
          echo "listen on receiver: nc -u -l $PORT"
          echo "test it:           echo 'netconsole test' | sudo tee /dev/kmsg"
        '';
      };
      
      panicInflate = pkgs.writers.writePython3Bin "drm-panic-inflate" {
        flakeIgnore = [ "E501" ];
      } ''
        import sys
        import zlib

        data = sys.stdin.buffer.read()
        if not data:
            sys.exit("Could not read QR: try a clearer, straighter photo")

        # Try raw deflate, then zlib-wrapped, then gzip.
        for wbits in (-15, 15, 47):
            try:
                sys.stdout.buffer.write(zlib.decompress(data, wbits))
                break
            except zlib.error:
                continue
        else:
            sys.stderr.write("warning: could not decompress, printing raw bytes\n")
            sys.stdout.buffer.write(data)
      '';

      drmPanicDecode = pkgs.writeShellApplication {
        name = "drm-panic-decode";
        runtimeInputs = [
          pkgs.zbar
          panicInflate
        ];
        text = ''
          if [ "$#" -lt 1 ]; then
            echo "usage: drm-panic-decode <panic-screen-photo>" >&2
            exit 1
          fi

          zbarimg --raw -q --oneshot -Sbinary "$1" | drm-panic-inflate
        '';
      };
    in
    {
      environment.systemPackages = [
        netconsole
        drmPanicDecode
      ];

      boot.kernelParams = [
        "reserve_mem=8M:4096:oops"
        "drm.panic_screen=qr_code"
      ];

      boot.kernelModules = [
        "ramoops"
        "iTCO_wdt"
      ];
      boot.extraModprobeConfig = ''
        options ramoops mem_name=oops record_size=262144 max_reason=3 ecc=1
      '';

      boot.kernel.sysctl = {
        "kernel.panic" = 30;

        "kernel.hardlockup_panic" = 1;

        "kernel.softlockup_panic" = 1;

        "kernel.hung_task_panic" = 1;

        "kernel.hung_task_timeout_secs" = 300;

        "kernel.sysrq" = 184;
      };
      systemd.settings.Manager = {
        RuntimeWatchdogSec = "60s";
        RebootWatchdogSec = "10min";
      };
    };
}
