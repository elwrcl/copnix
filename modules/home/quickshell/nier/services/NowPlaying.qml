pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// The MPRIS player the NieR player shows: the playing one, else the one whose
// play state changed last, else the first; null when there is none.
Singleton {
    id: root

    // Set by PlayerSurface while it is on screen; position only ticks then.
    property bool monitoring: false

    property MprisPlayer lastActive: null
    readonly property var all: Mpris.players.values
    readonly property MprisPlayer player: {
        const list = Array.from(all);
        return list.find(p => p.isPlaying) ?? (list.includes(lastActive) ? lastActive : (list[0] ?? null));
    }

    readonly property string title: player?.trackTitle || (player ? "UNKNOWN TRACK" : "NO SIGNAL")
    readonly property string artist: player?.trackArtist ?? ""
    readonly property string artUrl: player?.trackArtUrl ?? ""
    readonly property bool playing: player?.isPlaying ?? false
    readonly property real position: player?.position ?? 0
    readonly property real length: Math.max(1, player?.length ?? 0)

    function playPause() {
        if (player?.canTogglePlaying)
            player.togglePlaying();
    }
    function next() {
        if (player?.canGoNext)
            player.next();
    }
    function previous() {
        if (player?.canGoPrevious)
            player.previous();
    }
    function seekTo(secs: real) {
        if (player?.canSeek && player?.positionSupported)
            player.position = secs;
    }

    Instantiator {
        model: Mpris.players
        delegate: Connections {
            required property MprisPlayer modelData
            target: modelData
            function onIsPlayingChanged() {
                root.lastActive = modelData;
            }
        }
    }

    // MPRIS position is not reactive; poll it only while someone looks.
    Timer {
        interval: 1000
        repeat: true
        running: root.monitoring && root.playing
        onTriggered: root.player?.positionChanged()
    }
}
