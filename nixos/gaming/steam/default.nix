{
  config,
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    gamescopeSession = {
      enable = true;
      env = {
        STEAM_ALREADY_GAMESCOPED = "1";
        SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
        WINE_MOUSE_WARP_OVERRIDE = "force";
      };
      args = [
        "--fullscreen"
        "--force-grab-cursor"
      ];
    };

    package = pkgs.steam.override {
      extraEnv = {
        STEAM_USE_PORTAL = "1";
        GTK_USE_PORTAL = "1";
        PRESSURE_VESSEL_VERBOSE = "0";
        STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
      };
      extraPkgs =
        p: with p; [
          xdg-desktop-portal
          xdg-desktop-portal-gtk
          liberation_ttf
          wqy_zenhei
          corefonts
          vista-fonts
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
          libgpg-error
          libkrb5
          keyutils
          bash
          coreutils
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          gamemode
          zenity
          glib
          dbus
          at-spi2-atk
          atk
          pkgsi686Linux.libgcc
          pkgsi686Linux.glibc
          pkgsi686Linux.mesa
          pkgsi686Linux.libGL
          pkgsi686Linux.libpulseaudio
        ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.bash.enable = true;
  hardware.graphics.enable = true;
  hardware.steam-hardware.enable = true;
  environment.systemPackages = [
    (pkgs.lib.hiPrio (
      pkgs.writeShellScriptBin "steam" ''
        REAL_STEAM="${config.programs.steam.package}/bin/steam"

        if [ -n "$STEAM_ALREADY_GAMESCOPED" ] || [ -n "$GAMESCOPE_WAYLAND_DISPLAY" ]; then
          exec "$REAL_STEAM" "$@"
        fi

        if [ "$STEAM_USE_GAMESCOPE" = "1" ] && command -v steam-gamescope >/dev/null 2>&1; then
          exec steam-gamescope "$@"
        fi

        exec "$REAL_STEAM" "$@"
      ''
    ))
  ];
}
