{ ... }:
{
  flake.nixosModules.service-ssh =
    { ... }:
    {
      services.tailscale.enable = true;

      services.openssh = {
        enable = true;
        openFirewall = false;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 22 ];
      networking.firewall.trustedInterfaces = [ "tailscale0" ];
    };
}
