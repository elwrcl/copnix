{ ... }:
{
  flake.nixosModules.net-dpi-evasion =
    { ... }:
    {
      environment.etc."zapret/exclude.txt".text = ''
        turkiye.gov.tr
        sahibinden.com
        gov.tr
        edevlet.gov.tr
      '';

      services.zapret = {
        enable = true;
        configureFirewall = false;

        params = [
          "--filter-tcp=80"
          "--hostlist-exclude=/etc/zapret/exclude.txt"
          "--dpi-desync=fake,multisplit"
          "--dpi-desync-split-pos=method+2"
          "--dpi-desync-fooling=md5sig"
          "--new"
          "--filter-tcp=443"
          "--hostlist-exclude=/etc/zapret/exclude.txt"
          "--dpi-desync=fake,multidisorder"
          "--dpi-desync-split-pos=1,midsld"
          "--dpi-desync-fooling=badseq,md5sig"
          "--new"
          "--filter-udp=443"
          "--hostlist-exclude=/etc/zapret/exclude.txt"
          "--dpi-desync=fake"
          "--dpi-desync-repeats=6"
        ];
      };

      networking.enableIPv6 = true;
      networking.firewall.extraCommands = ''
        iptables  -I OUTPUT -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass
        iptables  -I OUTPUT -p udp --dport 443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass
        iptables  -I OUTPUT -m mark --mark 0x40000000/0x40000000 -j RETURN

        ip6tables -I OUTPUT -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass
        ip6tables -I OUTPUT -p udp --dport 443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass
        ip6tables -I OUTPUT -m mark --mark 0x40000000/0x40000000 -j RETURN
      '';

      networking.firewall.extraStopCommands = ''
        iptables  -D OUTPUT -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass || true
        iptables  -D OUTPUT -p udp --dport 443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass || true
        iptables  -D OUTPUT -m mark --mark 0x40000000/0x40000000 -j RETURN || true

        ip6tables -D OUTPUT -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass || true
        ip6tables -D OUTPUT -p udp --dport 443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:9 -j NFQUEUE --queue-num 200 --queue-bypass || true
        ip6tables -D OUTPUT -m mark --mark 0x40000000/0x40000000 -j RETURN || true
      '';
    };
}
