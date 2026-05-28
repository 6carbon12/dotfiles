import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import "../globals"
import "../components"

PillModule {
  id: root
  paddingX: 16
  spacing: 8 
  color: isMuted ? Theme.lightGray : Theme.lightBlue
  hasText: false

  property var sink: Pipewire.defaultAudioSink
  PwObjectTracker {
    objects: [root.sink]
  }
  property int volume: (sink && sink.audio) ? Math.round(sink.audio.volume * 100) : 0
  property bool isMuted: (sink && sink.audio) ? sink.audio.muted : false
  property string icon: {
    if (volume >= 60) { return "" }
    if (volume >= 30) { return "" }
    if (isMuted || volume === 0) { return "" } 
    return ""
  }

  // Custom text module that has fixed width
  Text {
    text: root.icon
    color: Theme.text
    Layout.preferredWidth: 14
    Layout.topMargin: 2
    font {
      family: Theme.fontFamily
      pixelSize: 14
      weight: Font.Bold
    }

    MouseArea {
      anchors.fill: parent
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
    snapMode: Slider.SnapAlways

    value: (root.sink && root.sink.audio) ? root.sink.audio.volume : 0.0

    onMoved: {
      if (root.sink && root.sink.audio) {
        root.sink.audio.volume = value

        if (root.sink.audio.muted && value > 0) {
          root.sink.audio.muted = false
        }
      }
    }

    background: Rectangle {
      width: volumeSlider.availableWidth
      height: 6
      radius: 3
      color: Qt.darker(Theme.lightGray, 1.5)
      anchors.verticalCenter: parent.verticalCenter

      Rectangle { // Filled Area
        width: root.isMuted ? 0 : (volumeSlider.visualPosition * parent.width)
        height: parent.height
        color: Theme.text
        radius: 3

        Rectangle {
          visible: root.volume > 100
          width: ((root.volume - 100)/100 * parent.width)
          height: parent.height
          color: Theme.lightRed
          radius: parent.height / 2
        }
      }
    }

    handle: Rectangle {
      x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
      y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
      width: 10
      height: 10
      radius: 7
      color: root.isMuted ? Theme.darkGray : Theme.text
      border.width: 2
      border.color: Theme.text
    }
  }
}
