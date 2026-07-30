pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "globals"

Scope {
  id: globalOsdState

  property bool isShown: false
  readonly property var sink: Pipewire.defaultAudioSink

  Timer {
    id: closeTimer
    interval: 1500
    onTriggered: globalOsdState.isShown = false
  }

  IpcHandler {
    target: "volumeOSD"

    function volumeUp(): void {
      globalOsdState.isShown = Hyprland.focusedWorkspace.hasFullscreen
      closeTimer.restart()
      if (globalOsdState.sink && globalOsdState.sink.audio && (globalOsdState.sink.audio.volume < 1.5)) {
        globalOsdState.sink.audio.volume += 0.05
      }
    }
    function volumeDown(): void {
      globalOsdState.isShown = Hyprland.focusedWorkspace.hasFullscreen
      closeTimer.restart()
      if (globalOsdState.sink && globalOsdState.sink.audio) {
        globalOsdState.sink.audio.volume -= 0.05
      }
    }
    function mute(): void {
      globalOsdState.isShown = Hyprland.focusedWorkspace.hasFullscreen
      closeTimer.restart()
      if (globalOsdState.sink && globalOsdState.sink.audio) {
        globalOsdState.sink.audio.muted = !globalOsdState.sink.audio.muted
      }
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData

      id: volumeOSD
      screen: modelData

      implicitHeight: 160 + 100
      implicitWidth: 48

      visible: globalOsdState.isShown && isActiveScreen
      property bool isActiveScreen: Hyprland.focusedMonitor && (Hyprland.focusedMonitor.name === screen.name)

      anchors {
        right: true
        top: true
      }

      margins {
        top: screen.height / 2 - height / 2
        right: 16
      }
      color: "transparent"

      readonly property bool isBluetooth: globalOsdState.sink && globalOsdState.sink.properties && (globalOsdState.sink.properties["device.api"] == "bluez5")
      readonly property int volume: (globalOsdState.sink && globalOsdState.sink.audio) ? Math.round(globalOsdState.sink.audio.volume * 100) : 0
      readonly property bool isMuted: (globalOsdState.sink && globalOsdState.sink.audio) ? globalOsdState.sink.audio.muted : false

      readonly property string icon: {
        let device = isBluetooth ? "headset" : "speaker"
        if (isMuted || volume === 0)  { return `assets/volume/${device}/mute.svg` }
        if (volume <= 25)  { return `assets/volume/${device}/low.svg` }
        if (volume <= 50)  { return `assets/volume/${device}/mid.svg` }
        if (volume <= 75)  { return `assets/volume/${device}/high.svg` }
        if (volume <= 100) { return `assets/volume/${device}/max.svg` }
        if (volume > 100)  { return `assets/volume/${device}/max.svg` }
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
              implicitHeight: 100 + 100
              stepSize: 0.05
              orientation: Qt.Vertical

              value: (volumeOSD.volume > 100) ? (volumeOSD.volume - 100)/100 : volumeOSD.volume/100
              Behavior on value { NumberAnimation { duration: 150; } }

              onMoved: {
                if (globalOsdState.sink && globalOsdState.sink.audio) {
                  globalOsdState.sink.audio.volume = value
                  if (volumeOSD.isMuted && value > 0) {
                    globalOsdState.sink.audio.muted = false
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
}
