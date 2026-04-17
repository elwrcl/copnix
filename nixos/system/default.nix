{ ... }:

{
  imports = [
    ./locale
    ./nix
    ./power.nix
    ./fonts
    ./qml.nix
  ];
  gtk.gtk4.theme = null;
}
