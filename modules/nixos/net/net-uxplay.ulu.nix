{ ... }:
{
  flake.nixosModules.net-uxplay =
    { pkgs, ... }:
    let
      uxplay = pkgs.uxplay.override {
        avahi = pkgs.avahi.override { withLibdnssdCompat = true; };
      };
      uxplay-fixed-ports = pkgs.symlinkJoin {
        name = "uxplay-fixed-ports";
        paths = [ uxplay ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/uxplay --add-flags "-p"
        '';
      };
    in
    {
      environment.systemPackages = [ uxplay-fixed-ports ];

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
        publish = {
          enable = true;
          userServices = true;
        };
      };

      networking.firewall = {
        allowedTCPPorts = [
          7000
          7001
          7100
        ];
        allowedUDPPorts = [
          6000
          6001
          7011
        ];
      };
    };
}
