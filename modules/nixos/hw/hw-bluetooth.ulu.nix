{ ... }:
{
  flake.nixosModules.hw-bluetooth =
    { ... }:
    {
      hardware.bluetooth.enable = true;
    };
}
