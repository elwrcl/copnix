{ ... }:
{
  flake.nixosModules.service-security =
    { ... }:
    {
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = false;
      };

      services.gnome.gnome-keyring.enable = true;
    };
}
