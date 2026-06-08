{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  xdg.portal.config.plasma.default = [ "kde" ];

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-browser-integration
    kdePackages.kwalletmanager
  ];
}
