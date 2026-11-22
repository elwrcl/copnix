pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// Unit-3's Theme.qml property names, fed by home-theme-quickshell's JSON.
// The variant follows noctalia's [theme] mode in its settings.toml (valw
// reads the same key); elars-theme/current is a symlink swap that file
// watchers miss. Unit-3's own colours are the fallback.
Singleton {
    readonly property string stateHome: Quickshell.env("XDG_STATE_HOME") || Quickshell.env("HOME") + "/.local/state"
    readonly property string configHome: Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.config"

    readonly property string mode: {
        const m = /^\[theme\][^\[]*?^mode\s*=\s*"(\w+)"/m.exec(settings.text());
        return m && m[1] === "light" ? "light" : "dark";
    }

    readonly property var j: {
        const t = file.text();
        if (!t)
            return {};
        try {
            return JSON.parse(t);
        } catch (e) {
            console.warn("nier theme: bad JSON:", e);
            return {};
        }
    }

    readonly property color bg: j.bg ?? "#0b0a09"
    readonly property color bg2: j.bg2 ?? "#111008"
    readonly property color bg3: j.bg3 ?? "#1a1814"
    readonly property color fg: j.fg ?? "#c8b89a"
    readonly property color fgd: j.fgd ?? "#80c8b89a"
    readonly property color fgdd: j.fgdd ?? "#33c8b89a"
    readonly property color ln: j.ln ?? "#1Fc8b89a"
    readonly property color lnm: j.lnm ?? "#38c8b89a"
    readonly property color a1: j.a1 ?? "#c87060"
    readonly property color a2: j.a2 ?? "#60a880"
    readonly property color a3: j.a3 ?? "#6090c8"
    readonly property color a4: j.a4 ?? "#c8a860"
    readonly property string mono: j.mono ?? "Share Tech Mono"

    readonly property int durationFast: 150
    readonly property int durationMid: 380
    readonly property int durationSlow: 650

    FileView {
        id: settings
        path: stateHome + "/noctalia/settings.toml"
        watchChanges: true
        printErrors: false
        onFileChanged: reload()
    }

    FileView {
        id: file
        path: configHome + "/elars-theme/" + mode + "/quickshell-theme.json"
        watchChanges: true
        printErrors: false
        onFileChanged: reload()
    }
}
