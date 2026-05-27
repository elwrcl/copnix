{
  pkgs,
  inputs,
  system,
  ...
}:

{
  imports = [
    ./shared.nix
    ./hyprland.nix
  ];

  services.easyeffects.enable = true;

  home.homeDirectory = "/home/elars";

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-application-prefer-dark-theme = true;
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
    };
  };

  home.sessionVariables = {
    BROWSER = "zen-beta.desktop";
  };

  home.packages = with pkgs; [
    # qol-hyprland
    wl-clipboard
    waybar
    easyeffects
    swappy
    grim
    slurp
    wf-recorder
    tesseract
    obs-studio
    mpvpaper

    # hardware tools (linux-only)
    vulkan-tools
    gpu-screen-recorder
    libva-utils
    mesa-demos
    intel-gpu-tools
    clinfo
    hidapi

    # apps
    heroic
    prismlauncher
    nautilus
    loupe
    whatsapp-electron
    spotatui
    antigravity
    picotool

    # input
    adwaita-qt
    gnome-icon-theme
    hicolor-icon-theme
    tango-icon-theme
    arc-icon-theme

    #inputs
    inputs.zen-browser.packages.${system}.default
    inputs.helium.packages.${system}.default
    inputs.noctalia.packages.${system}.default
    inputs.copetch.packages.${system}.default
    pkgs.qt6Packages.qtwebsockets
    pkgs.evil-helix_git
  ];
}
