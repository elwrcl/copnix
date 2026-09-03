{ ... }:
{
  flake.homeModules.home-easyeffects =
    { ... }:
    {
      xdg.configFile."easyeffects/output/hyperx.json".source = ./hyperx.json;
      xdg.configFile."easyeffects/input/hyperx.json".source = ./hyperx-mic.json;
      xdg.configFile."easyeffects/irs/HyperXCloudAS-48000Hz.wav".source = ./HyperXCloudAS-48000Hz.wav;

      services.easyeffects = {
        enable = true;
        preset = "hyperx";
      };
    };
}
