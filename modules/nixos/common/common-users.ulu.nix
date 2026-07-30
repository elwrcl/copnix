{ ... }:
{
  flake.nixosModules.common-users =
    { pkgs, ... }:
    {
      users.users.elars = {
        isNormalUser = true;
        linger = true;
        description = "elars";
        extraGroups = [
          "networkmanager"
          "libvirtd"
          "scanner"
          "plugdev"
          "docker"
          "video"
          "input"
          "audio"
          "wheel"
          "lp"
        ];
        shell = pkgs.zsh;
      };

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/elars/copland";
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
}
