import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import "../globals"
import "../components"

PillModule {
  id: sound
  hasText: false
  paddingX: 16
  spacing: 8
  color: isMuted ? Theme.colors.disabled : Theme.colors.primary
  Behavior on color { ColorAnimation { duration: 150; } }

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property bool isBluetooth: sink && sink.properties && (sink.properties["device.api"] == "bluez5")
  readonly property int volume: (sink && sink.audio) ? Math.round(sink.audio.volume * 100) : 0
  readonly property bool isMuted: (sink && sink.audio) ? sink.audio.muted : false
  readonly property string icon: {
    let device = isBluetooth ? "headset" : "speaker"
    if (isMuted || 
        volume === 0)  { return `../assets/volume/${device}/mute.svg` }
    if (volume <= 25)  { return `../assets/volume/${device}/low.svg` }
    if (volume <= 50)  { return `../assets/volume/${device}/mid.svg` }
    if (volume <= 75)  { return `../assets/volume/${device}/high.svg` }
    if (volume <= 100) { return `../assets/volume/${device}/max.svg` }
    if (volume > 100)  { return `../assets/volume/${device}/max.svg` }
  }

  PwObjectTracker { objects: [sound.sink] }

  // Custom icon that changes based on the volume
  Image {
    id: volIcon
    source: sound.icon
    cache: false
    Layout.preferredWidth: 16
    sourceSize.width: Layout.preferredWidth
    sourceSize.height: height
    fillMode: Image.PreserveAspectFit

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

  Slider {
    id: volumeSlider
    from: 0.0
    to: 1.0
    Layout.preferredWidth: 100 
    implicitHeight: 24 // Important to make mouse work
    stepSize: 0.05

    value: (sound.volume > 100) ? (sound.volume - 100)/100 : sound.volume/100
    Behavior on value { NumberAnimation { duration: 150; } }

    onMoved: {
      if (sound.sink && sound.sink.audio) {
        sound.sink.audio.volume = value

        if (sound.isMuted && value > 0) {
          sound.sink.audio.muted = false
        }
      }
    }

    background: Rectangle {
      // Unslided area
      width: volumeSlider.availableWidth
      height: 6
      radius: 3
      color: (sound.volume > 100) ? Theme.colors.background : Theme.palette.neutral500
      anchors.verticalCenter: parent.verticalCenter

      // Slided area (< 100%)
      Rectangle {
        width: (sound.volume > 100) ? volumeSlider.width : (volumeSlider.visualPosition * parent.width)
        height: parent.height
        color: Theme.colors.background
        radius: height / 2
      }

      // Slided area (> 100%)
      Rectangle {
        visible: sound.volume > 100
        width: parent.width * ((sound.volume - 100)/100)
        Behavior on width { NumberAnimation { duration: 150; } }
        height: parent.height
        color: Theme.colors.danger
        radius: height / 2
      }
    }

    handle: Rectangle {
      x: volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
      y: volumeSlider.availableHeight / 2 - height / 2
      width: 10
      height: 10
      radius: height / 2
      color: Theme.palette.neutral400
      border.width: 2
      border.color: Theme.colors.background
    }
  }
}
