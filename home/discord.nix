{
  pkgs,
  ...
}:

{
  programs.nixcord = {
    enable = true;

    discord = {
      enable = true;
      package = pkgs.discord-canary;

      equicord.enable = true;
      vencord.enable = false;

      openASAR.enable = true;
    };
  };
}
