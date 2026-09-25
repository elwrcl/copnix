{ ... }:
{
  flake.homeModules.home-gdrive-rclone =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.rclone ];

      systemd.user.services.rclone-gdrive = {
        Unit = {
          Description = "Google Drive (rclone mount)";
          After = [ "network-online.target" ];
        };
        Service = {
          Type = "notify";
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/GoogleDrive";
          ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: %h/GoogleDrive --vfs-cache-mode writes";
          ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/GoogleDrive";
          Restart = "on-failure";
          RestartSec = 10;
        };
        Install.WantedBy = [ "default.target" ];
      };
    };
}
