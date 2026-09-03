{ ... }:
{
  flake.nixosModules.net-network-manager =
    { lib, ... }:
    let
      inherit (lib.modules) mkDefault mkForce;
    in
    {
      networking.networkmanager = {
        enable = true;
        dns = mkForce "none";
        settings.main.systemd-resolved = false;
        ethernet.macAddress = mkDefault "stable";
        wifi.macAddress = mkDefault "random";
        wifi.scanRandMacAddress = true;
        connectionConfig = {
          "ipv6.addr-gen-mode" = "stable-privacy";
          "ipv6.ip6-privacy" = 2;
        };
      };
      networking.tempAddresses = "enabled";

      services.resolved = {
        enable = true;
        settings.Resolve = {
          DNS = [
            "9.9.9.9#dns.quad9.net"
            "149.112.112.112#dns.quad9.net"
            "2620:fe::fe#dns.quad9.net"
            "2620:fe::9#dns.quad9.net"
          ];

          FallbackDNS = [
            "194.242.2.2#dns.mullvad.net"
            "2a07:e340::2#dns.mullvad.net"
          ];
          DNSOverTLS = "yes";
          DNSSEC = "true";
          Domains = [ "~." ];
          LLMNR = "false";
          MulticastDNS = "false";
        };
      };
    };
}
