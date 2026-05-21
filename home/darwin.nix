{
  pkgs,
  ...
}:

{
  imports = [ ./shared.nix ];

  home.homeDirectory = "/Users/elars";

  # macOS-shell
  home.sessionVariables = {
    BROWSER = "open";
  };

  home.packages = with pkgs; [
    # buraya ekleyecem
  ];
}
