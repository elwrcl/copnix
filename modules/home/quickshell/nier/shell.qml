import QtQuick
import Quickshell
import "surfaces"
import "theme"

// NieR pieces next to noctalia: hidden until toggled over IPC, idle otherwise.
ShellRoot {
    PlayerSurface {}
    WallpaperSurface {}

    Connections {
        target: Theme
        function onBgChanged() {
            console.info("nier theme bg:", Theme.bg);
        }
    }
    Component.onCompleted: console.info("nier theme bg:", Theme.bg)
}
