{ ... }:
{
  flake.homeModules.home-keepassxc-autostart =
    { config, ... }:
    {
      programs.keepassxc.settings.GUI = {
        ShowTrayIcon = true;
        MinimizeToTray = true;
        MinimizeOnClose = true;
      };

      systemd.user.services.keepassxc = {
        Unit = {
          Description = "KeePassXC";
          PartOf = [ "graphical-session.target" ];
          After = [
            "graphical-session.target"
            "rclone-gdrive.service"
          ];
          Wants = [ "rclone-gdrive.service" ];
        };
        Service = {
          ExecStart = "${config.programs.keepassxc.package}/bin/keepassxc --minimized";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
}
