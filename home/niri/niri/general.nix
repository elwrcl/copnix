''
  prefer-no-csd

  debug {
    honor-xdg-activation-with-invalid-serial
  }

  input {
    keyboard {
      xkb {
        layout "tr"
      }
      numlock
      repeat-delay 250
      repeat-rate 35
    }

    mouse {
      accel-profile "flat"
      accel-speed 0.0
    }

    touchpad {
      natural-scroll
      dwt
      click-method "clickfinger"
      scroll-factor 0.8
    }

    focus-follows-mouse
  }

  layout {
    gaps 5

    center-focused-column "never"

    focus-ring {
      width 1
      active-color "#33ccffee"
      inactive-color "#31313600"
    }

    default-column-width {}
  }

  window-rule {
    geometry-corner-radius 18
    clip-to-geometry true
  }

  animations {
    window-open {
      duration-ms 250
      curve "ease-out-expo"
    }
    window-close {
      duration-ms 200
      curve "ease-out-expo"
    }
    horizontal-view-movement {
      duration-ms 350
      curve "ease-out-expo"
    }
    workspace-switch {
      duration-ms 350
      curve "ease-out-expo"
    }
    window-movement {
      duration-ms 250
      curve "ease-out-expo"
    }
    window-resize {
      duration-ms 250
      curve "ease-out-expo"
    }
  }
''