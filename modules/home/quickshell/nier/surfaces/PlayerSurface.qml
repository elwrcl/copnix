import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../services"
import "../widgets"

// Music player surface; toggled by `qs -c nier ipc call player toggle`.
// Opens on niri's focused output only. The layer surface is only mapped while
// shown or animating out, so it never sits invisibly over windows.
Scope {
    id: root

    property bool shown: false
    // an open waiting for niri's focused output; a second press cancels it
    property bool pending: false
    property var screen: Quickshell.screens[0] ?? null

    Binding {
        target: NowPlaying
        property: "monitoring"
        value: root.shown
    }

    // Covers Player's hide animation (curtain + slide-out) before unmapping.
    Timer {
        id: linger
        interval: 900
    }

    IpcHandler {
        target: "player"

        function toggle(): void {
            if (root.pending) {
                root.pending = false;
                return;
            }
            if (root.shown) {
                root.shown = false;
                linger.restart();
                return;
            }
            root.pending = true;
            FocusedOutput.query(name => {
                if (!root.pending)
                    return;
                root.pending = false;
                linger.stop();
                root.screen = FocusedOutput.screenNamed(name);
                root.shown = true;
            });
        }
    }

    PanelWindow {
        screen: root.screen
        visible: root.shown || linger.running

        anchors.top: true
        anchors.right: true
        margins.top: Math.round((root.screen?.height ?? 768) * 0.39)
        margins.right: 20
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.namespace: "nier-player"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
        color: "transparent"
        implicitWidth: player.pw
        implicitHeight: player.implicitHeight

        Player {
            id: player
            anchors.fill: parent
            mpTitle: NowPlaying.title
            mpArtist: NowPlaying.artist
            mpCoverUrl: NowPlaying.artUrl
            mpPlaying: NowPlaying.playing
            mpPosition: NowPlaying.position
            mpLength: NowPlaying.length
            onPlayPause: NowPlaying.playPause()
            onNextTrack: NowPlaying.next()
            onPrevTrack: NowPlaying.previous()
            onSeekTo: secs => NowPlaying.seekTo(secs)
        }

        Connections {
            target: root
            function onShownChanged() {
                if (player.shown !== root.shown)
                    player.toggleVisible();
            }
        }
    }
}
