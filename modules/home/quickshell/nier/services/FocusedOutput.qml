pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

// niri's focused output, asked once per open (no polling).
Singleton {
    id: root

    property var pending: []

    // cb(name: string), "" when niri does not answer.
    function query(cb) {
        pending.push(cb);
        if (!proc.running)
            proc.running = true;
    }

    // The ShellScreen called `name`, else the first one.
    function screenNamed(name: string): var {
        return Quickshell.screens.find(s => s.name === name) ?? Quickshell.screens[0] ?? null;
    }

    Process {
        id: proc
        command: ["niri", "msg", "--json", "focused-output"]
        stdout: StdioCollector {
            onStreamFinished: {
                let name = "";
                try {
                    name = JSON.parse(text)?.name ?? "";
                } catch (e) {}
                const cbs = root.pending;
                root.pending = [];
                cbs.forEach(cb => cb(name));
            }
        }
    }
}
