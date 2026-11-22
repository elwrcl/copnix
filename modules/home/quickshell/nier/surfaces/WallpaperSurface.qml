import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../services"
import "../widgets"

// Wallpaper picker surface; toggled by `qs -c nier ipc call wallpaper toggle`.
// Opens full screen on niri's focused output, lists noctalia's wallpaper
// directory and hands the choice to noctalia, so its transitions and theme
// regeneration run as usual.
Scope {
    id: root

    property bool shown: false
    // an open waiting for the directory and focused output; a second press cancels it
    property bool pending: false
    property bool mapped: false
    property var screen: Quickshell.screens[0] ?? null
    property string outputName: ""
    property string directory: ""

    IpcHandler {
        target: "wallpaper"

        function toggle(): void {
            if (root.pending) {
                root.pending = false;
                return;
            }
            if (root.shown) {
                root.shown = false;
                picker.close();
                return;
            }
            root.pending = true;
            dirProc.running = true;
        }
    }

    // `config-get` prints a TOML value: '/path' (or "" when unset).
    Process {
        id: dirProc
        command: ["noctalia", "msg", "config-get", "wallpaper.directory"]
        stdout: StdioCollector {
            onStreamFinished: {
                const dir = text.trim().replace(/^['"]|['"]$/g, "");
                root.directory = dir || Quickshell.env("HOME") + "/Pictures";
                FocusedOutput.query(name => {
                    if (!root.pending)
                        return;
                    root.pending = false;
                    root.shown = true;
                    root.outputName = name;
                    root.screen = FocusedOutput.screenNamed(name);
                    root.mapped = true;
                    Qt.callLater(picker.open);
                });
            }
        }
    }

    PanelWindow {
        screen: root.screen
        visible: root.mapped

        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "nier-wallpaper"
        WlrLayershell.keyboardFocus: root.shown ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
        color: "transparent"

        WallpaperPicker {
            id: picker
            anchors.fill: parent
            directory: root.directory
            outputName: root.outputName

            onApply: (path, output) => {
                Quickshell.execDetached(output ? ["noctalia", "msg", "wallpaper-set", output, path] : ["noctalia", "msg", "wallpaper-set", path]);
            }
            onClosed: {
                root.shown = false;
                root.mapped = false;
            }
        }
    }
}
