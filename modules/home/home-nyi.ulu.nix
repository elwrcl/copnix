{ ... }:
{
  flake.homeModules.home-nyi =
    { inputs, ... }:
    {
      imports = [
        inputs.nyi.homeManagerModules.default
      ];

      programs.nyi = {
        enable = true;
        info = [
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "wm"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "disk"
          "colors"
        ];
        labelColor = "white";
        separator = "-";
        box = false;
        shading = null;
        shadingMode = "sextants";
        logoOuter = null;
        logoInner = null;
        light = "top";
        spin = "y";
        speed = null;
        size = null;
        height = null;
        depth = null;
        disks = [
          "/mnt/HDD/linuxdata"
          "/mnt/HDD/shared"
        ];
        logo = null;
        logoDistro = null;
        extraConfig = "";
      };
    };
}
