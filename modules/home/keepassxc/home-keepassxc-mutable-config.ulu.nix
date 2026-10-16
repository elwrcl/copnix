{ ... }:
{
  flake.homeModules.home-keepassxc-mutable-config =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.keepassxc;
      ini = "${config.xdg.configHome}/keepassxc/keepassxc.ini";
      declared = (pkgs.formats.ini { }).generate "keepassxc-declared.ini" cfg.settings;
    in
    {
      xdg.configFile."keepassxc/keepassxc.ini".enable = lib.mkForce false;

      home.activation.keepassxcConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        if [ -L ${ini} ]; then
          run rm ${ini}
        fi
        run mkdir -p ${config.xdg.configHome}/keepassxc
        run touch ${ini}
        run ${pkgs.crudini}/bin/crudini --merge ${ini} < ${declared}
      '';
    };
}
