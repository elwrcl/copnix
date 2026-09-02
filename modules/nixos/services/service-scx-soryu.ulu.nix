{ inputs, ... }:
{
  flake.nixosModules.service-scx-soryu =
    { lib, ... }:
    {
      imports = [ inputs.scx_soryu.nixosModules.default ];

      services.scx-soryu = {
        enable = true;
        notify.user = "elars";
      };
      boot.kernel.sysctl."kernel.sysrq" = lib.mkForce 440;
    };
}
