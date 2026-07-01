import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "globals"

Variants {
  model: Quickshell.screens

  PanelWindow {
    required property ShellScreen modelData

    id: volumeOSD
    screen: modelData
    implicitHeight: 160 + 100
    implicitWidth: 48
    visible: !hasFullScreen ? false : isShown
    property bool hasFullScreen: Hyprland.focusedWorkspace.hasFullscreen
    property bool isShown: false

    anchors {
      right: true
      top: true
    }

    margins {
      top: screen.height / 2 - height / 2
      right: 16
    }
    color: "transparent"

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool isBluetooth: sink && sink.properties && (sink.properties["device.api"] == "bluez5")
    readonly property int volume: (sink && sink.audio) ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool isMuted: (sink && sink.audio) ? sink.audio.muted : false
    readonly property string icon: {
      let device = isBluetooth ? "headset" : "speaker"
      if (isMuted ||
      volume === 0)  { return `assets/volume/${device}/mute.svg` }
      if (volume <= 25)  { return `assets/volume/${device}/low.svg` }
      if (volume <= 50)  { return `assets/volume/${device}/mid.svg` }
      if (volume <= 75)  { return `assets/volume/${device}/high.svg` }
      if (volume <= 100) { return `assets/volume/${device}/max.svg` }
      if (volume > 100)  { return `assets/volume/${device}/max.svg` }
    }

    Timer {
      id: closeTimer
      interval: 1500
      onTriggered: {
        volumeOSD.isShown = false
      }
    }

    IpcHandler {
      target: "volumeOSD"

      function volumeUp(): void {
        volumeOSD.isShown = true
        closeTimer.restart()
        volumeOSD.sink.audio.volume += 0.05
        console.log(volumeOSD.hasFullScreen)
      }
      function volumeDown(): void {
        volumeOSD.isShown = true
        closeTimer.restart()
        volumeOSD.sink.audio.volume -= 0.05
      }
      function mute(): void {
        volumeOSD.isShown = true
        closeTimer.restart()
        volumeOSD.sink.audio.muted = !volumeOSD.sink.audio.muted
      }
    }

    Rectangle {
      anchors.fill: parent
      color: volumeOSD.isMuted ? Theme.colors.disabled : Theme.colors.primary
      Behavior on color { ColorAnimation { duration: 150; } }
      radius: width / 2
      border.color: Theme.palette.neutral400

      Rectangle {
        anchors.fill: parent
        color: "transparent"

        anchors {
          topMargin: 16
          bottomMargin: 16
          leftMargin: 4
          rightMargin: 4
        }
        ColumnLayout {
          anchors.fill: parent
          Slider {
            id: volumeSlider
            from: 0.0
            to: 1.0
            Layout.preferredWidth: 24
            Layout.alignment: Qt.AlignHCenter
            implicitHeight: 100 + 100 // Important to make mouse work
            stepSize: 0.05
            orientation: Qt.Vertical

            value: (volumeOSD.volume > 100) ? (volumeOSD.volume - 100)/100 : volumeOSD.volume/100
            Behavior on value { NumberAnimation { duration: 150; } }

            onMoved: {
              if (volumeOSD.sink && volumeOSD.sink.audio) {
                volumeOSD.sink.audio.volume = value

                if (volumeOSD.isMuted && value > 0) {
                  volumeOSD.sink.audio.muted = false
                }
              }
            }

            background: Rectangle {
              height: volumeSlider.availableHeight
              width: 6
              radius: 3
              color: Theme.colors.background
              anchors.horizontalCenter: parent.horizontalCenter

              Rectangle {
                height: (volumeOSD.volume > 100) ? volumeSlider.height : (volumeSlider.visualPosition * parent.height)
                width: parent.width
                color: (volumeOSD.volume > 100) ? Theme.colors.background : Theme.palette.neutral500
                radius: height / 2
              }

              Rectangle {
                anchors.bottom: parent.bottom
                visible: volumeOSD.volume > 100
                height: parent.height * ((volumeOSD.volume - 100)/100)
                Behavior on height { NumberAnimation { duration: 150; } }
                width: parent.width
                color: Theme.colors.danger
                radius: height / 2
              }
            }

            handle: Rectangle {
              x: volumeSlider.width / 2 - width / 2
              // y: volumeSlider.availableWidth / 2 - height / 2
              y: volumeSlider.visualPosition * (volumeSlider.availableHeight - height)
              width: 10
              height: 10
              radius: height / 2
              color: Theme.palette.neutral400
              border.width: 2
              border.color: Theme.colors.background
            }
          }
          Image {
            id: volIcon
            source: volumeOSD.icon
            cache: false
            // Use different sizes of bluetooth and speaker since the SVGs of headset and speaker are of different sizes
            width: isBluetooth ? 18 : 16
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
              anchors.centerIn: parent
              height: parent.height + 16
              width: parent.width + 16
              cursorShape: Qt.PointingHandCursor
              onClicked: {
                Quickshell.execDetached(["kitty", "--class", "float-term", "--override", "window_padding_width=20", "pulsemixer"])
              }
            }
          }
        }
      }
    }

  }
}
