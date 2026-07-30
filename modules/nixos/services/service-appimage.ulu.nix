{ ... }:
{
  flake.nixosModules.service-appimage =
    { ... }:
    {
      programs.appimage = {
        enable = true;
        binfmt = true;
      };
    };
}
