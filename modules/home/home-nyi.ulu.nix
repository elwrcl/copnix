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
        labelColor = "magenta";
        separator = "-";
        box = false;
        shading = null;
        shadingMode = "sextants";
        logoOuter = null;
        logoInner = null;
        light = "top-left";
        spin = "xy";
        speed = null;
        size = null;
        height = null;
        depth = null;
        disks = [ ];
        logo = null;
        logoDistro = null;
        extraConfig = "";
      };
    };
}
