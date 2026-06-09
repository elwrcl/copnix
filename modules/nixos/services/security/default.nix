{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  security.wrappers = {
    gsr-kms-server = {
      source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
      owner = "root";
      group = "root";
      permissions = "u+rx,g+rx,o+rx";
    };
  };

  services.gnome.gnome-keyring.enable = true;
}
