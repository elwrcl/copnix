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
          "packages"
          "shell"
          "wm"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "disk"
        ];
        labelColor = "white";
        separator = "-";
        box = false;
        shading = null;
        shadingMode = "ascii";
        logoOuter = null;
        logoInner = null;
        light = "top";
        spin = "xy";
        speed = null;
        size = null;
        height = null;
        depth = null;
        disks = [
          "/mnt/HDD/linuxdata"
        ];
        logo = null;
        logoDistro = null;
        extraConfig = "";
      };
    };
}
