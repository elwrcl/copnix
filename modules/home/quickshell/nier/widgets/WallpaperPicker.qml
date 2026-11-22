// Derived from samyns/Unit-3 @ 0b45ac9 (MIT), see ../UNIT3-LICENSE.md
// Changes: an Item inside WallpaperSurface instead of a ShellRoot run per
// open; WipeCurtain over Theme.bg instead of the mp4 reveal/hide; images from
// noctalia's wallpaper directory (FolderListModel); applying is the surface's
// job (`noctalia msg wallpaper-set`); Theme colours for a dark palette.
import QtQuick
import Qt.labs.folderlistmodel
import "../components"
import "../theme"

Item {
    id: root

    property string directory: ""
    property string outputName: ""
    property bool shown: false

    // path: absolute file path; output: connector, or "" for every screen
    signal apply(string path, string output)
    signal closed

    property int currentIndex: 0
    readonly property int n: folder.count
    property bool contentHidden: true

    function open() {
        shown = true;
        contentHidden = false;
        currentIndex = 0;
        hideCover.stop();
        wipe.reveal();
        carousel.forceActiveFocus();
    }

    function close() {
        if (!shown)
            return;
        shown = false;
        wipe.hide();
        hideCover.restart();
    }

    function navigate(dir) {
        if (n === 0)
            return;
        currentIndex = ((currentIndex + dir) % n + n) % n;
    }

    function applyCurrent(output) {
        if (n === 0)
            return;
        apply(folder.get(currentIndex, "filePath"), output);
        close();
    }

    function fg(a) {
        return Qt.rgba(Theme.fg.r, Theme.fg.g, Theme.fg.b, a);
    }

    FolderListModel {
        id: folder
        folder: root.directory ? "file://" + root.directory : ""
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp", "*.bmp", "*.gif", "*.JPG", "*.JPEG", "*.PNG", "*.WEBP"]
        showDirs: false
        sortField: FolderListModel.Name
    }

    property string clockFull: "--:--:--"
    Timer {
        interval: 1000
        running: root.shown
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            const d = new Date(), p = x => String(x).padStart(2, "0");
            root.clockFull = p(d.getHours()) + ":" + p(d.getMinutes()) + ":" + p(d.getSeconds());
        }
    }

    // The curtain covers everything at 40 % of the hide; drop the content then.
    Timer {
        id: hideCover
        interval: Math.round(wipe.hideDuration * 0.4)
        onTriggered: root.contentHidden = true
    }

    WipeCurtain {
        id: wipe
        anchors.fill: parent
        revealDuration: Theme.durationSlow
        hideDuration: 600
        onHideFinished: root.closed()

        Item {
            anchors.fill: parent
            visible: !root.contentHidden

            Rectangle {
                anchors.fill: parent
                color: Qt.rgba(Theme.bg.r, Theme.bg.g, Theme.bg.b, 0.94)
            }
            Repeater {
                model: Math.ceil(root.width / 40)
                Rectangle {
                    x: index * 40
                    width: 1
                    height: root.height
                    color: root.fg(0.03)
                }
            }
            Scanlines {
                anchors.fill: parent
            }

            MouseArea {
                anchors.fill: parent
                onWheel: e => root.navigate(e.angleDelta.y < 0 ? 1 : -1)
            }

            // ── Corner labels ──
            Column {
                anchors {
                    top: parent.top
                    left: parent.left
                    topMargin: 28
                    leftMargin: 30
                }
                spacing: 2
                Row {
                    spacing: 5
                    Rectangle {
                        width: 5
                        height: 5
                        radius: 3
                        color: Theme.a1
                        anchors.verticalCenter: parent.verticalCenter
                        SequentialAnimation on opacity {
                            running: root.shown
                            loops: Animation.Infinite
                            NumberAnimation {
                                to: 0.3
                                duration: 900
                            }
                            NumberAnimation {
                                to: 1
                                duration: 900
                            }
                        }
                    }
                    Text {
                        text: "WALLPAPER SELECT"
                        font.family: Theme.mono
                        font.pixelSize: 9
                        font.letterSpacing: 2
                        color: root.fg(0.6)
                    }
                }
                Text {
                    text: "NODE · " + (root.outputName || "ALL")
                    font.family: Theme.mono
                    font.pixelSize: 9
                    font.letterSpacing: 2
                    color: root.fg(0.6)
                }
            }
            Text {
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 28
                    rightMargin: 30
                }
                text: root.clockFull
                font.family: Theme.mono
                font.pixelSize: 9
                font.letterSpacing: 2
                color: root.fg(0.6)
            }
            Text {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    bottomMargin: 28
                    leftMargin: 30
                }
                text: "←→ / SCROLL  NAVIGATE  ·  ENTER  APPLY  ·  ESC  QUIT"
                font.family: Theme.mono
                font.pixelSize: 9
                font.letterSpacing: 2
                color: root.fg(0.6)
            }

            Text {
                anchors.centerIn: parent
                visible: root.n === 0
                text: "NO IMAGES // " + (root.directory || "NO DIRECTORY")
                font.family: Theme.mono
                font.pixelSize: 11
                font.letterSpacing: 2
                color: root.fg(0.5)
            }

            // ── Carousel ──
            Item {
                id: carousel
                anchors.top: parent.top
                anchors.topMargin: 80
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height - 220

                focus: true
                Keys.onEscapePressed: root.close()
                Keys.onLeftPressed: root.navigate(-1)
                Keys.onRightPressed: root.navigate(1)
                Keys.onUpPressed: root.navigate(-1)
                Keys.onDownPressed: root.navigate(1)
                Keys.onReturnPressed: root.applyCurrent("")
                Keys.onEnterPressed: root.applyCurrent("")
                Keys.onSpacePressed: root.applyCurrent("")

                // Centre thumbnail at full scale, sized to the screen.
                readonly property int baseW: Math.min(800, Math.round(width * 0.58), Math.round(height * 0.8 / 0.625))
                readonly property int baseH: Math.round(baseW * 0.625)
                readonly property int baselineY: height / 2 + baseH / 2
                readonly property int offsetNear: Math.round(baseW * 0.35)
                readonly property int offsetFar: Math.round(baseW * 0.72)

                Repeater {
                    model: folder

                    Item {
                        id: thumb
                        required property int index
                        required property string filePath
                        required property string fileName

                        readonly property int delta: {
                            if (root.n === 0)
                                return 0;
                            let d = index - root.currentIndex;
                            const half = root.n / 2;
                            if (d > half)
                                d -= root.n;
                            if (d < -half)
                                d += root.n;
                            return d;
                        }
                        readonly property int absDelta: Math.abs(delta)

                        width: carousel.baseW
                        height: carousel.baseH
                        x: carousel.width / 2 - carousel.baseW / 2 + (absDelta === 0 ? 0 : Math.sign(delta) * (absDelta === 1 ? carousel.offsetNear : carousel.offsetFar))
                        y: carousel.baselineY - carousel.baseH
                        scale: absDelta === 0 ? 1.0 : absDelta === 1 ? 0.54 : 0.35
                        opacity: absDelta === 0 ? 1.0 : absDelta === 1 ? 0.65 : absDelta === 2 ? 0.3 : 0.0
                        z: absDelta === 0 ? 10 : 3 - absDelta
                        visible: absDelta <= 2
                        transformOrigin: Item.Bottom

                        Behavior on x {
                            NumberAnimation {
                                duration: 320
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on scale {
                            NumberAnimation {
                                duration: 320
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on opacity {
                            NumberAnimation {
                                duration: 320
                                easing.type: Easing.OutCubic
                            }
                        }

                        Rectangle {
                            anchors.fill: parent
                            color: Theme.bg3
                            border.color: thumb.absDelta === 0 ? Theme.fg : root.fg(0.3)
                            border.width: thumb.absDelta === 0 ? 2 : 1
                            Behavior on border.color {
                                ColorAnimation {
                                    duration: 260
                                }
                            }

                            Image {
                                anchors.fill: parent
                                anchors.margins: 2
                                // only near slots load; the rest stay unloaded
                                source: thumb.absDelta <= 2 ? "file://" + thumb.filePath : ""
                                sourceSize.width: 384
                                fillMode: Image.PreserveAspectCrop
                                asynchronous: true
                                smooth: true
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 24
                                color: Qt.rgba(Theme.bg.r, Theme.bg.g, Theme.bg.b, 0.7)
                                opacity: thumb.absDelta === 0 ? 1 : 0
                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 200
                                    }
                                }
                                Text {
                                    anchors.centerIn: parent
                                    width: parent.width - 16
                                    horizontalAlignment: Text.AlignHCenter
                                    elide: Text.ElideMiddle
                                    text: thumb.fileName
                                    font.family: Theme.mono
                                    font.pixelSize: 9
                                    color: Theme.fg
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: thumb.delta !== 0 ? root.navigate(thumb.delta) : root.applyCurrent("")
                            onWheel: e => root.navigate(e.angleDelta.y < 0 ? 1 : -1)
                        }
                    }
                }
            }

            // ── Apply panel ──
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 60
                width: 420
                height: applyCol.implicitHeight + 40
                color: Theme.bg2
                border.color: root.fg(0.3)
                border.width: 1
                visible: root.n > 0

                CornerDeco {
                    size: 14
                }

                Column {
                    id: applyCol
                    width: 348
                    anchors {
                        top: parent.top
                        topMargin: 20
                        horizontalCenter: parent.horizontalCenter
                    }
                    spacing: 10

                    Text {
                        text: "APPLY WALLPAPER"
                        font.family: Theme.mono
                        font.pixelSize: 10
                        font.letterSpacing: 3
                        color: Theme.fg
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: root.fg(0.22)
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 12
                        NierButton {
                            width: 162
                            height: 42
                            label: "THIS SCREEN"
                            fontSize: 10
                            fgColor: Theme.fg
                            visible: root.outputName !== ""
                            onClicked: root.applyCurrent(root.outputName)
                        }
                        NierButton {
                            width: 162
                            height: 42
                            label: "ALL SCREENS"
                            fontSize: 10
                            fgColor: Theme.fg
                            onClicked: root.applyCurrent("")
                        }
                    }
                }
            }
        }
    }
}
