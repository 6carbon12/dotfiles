import Quickshell
import QtQuick
import "globals"

Variants {
  model: Quickshell.screens

  PanelWindow {
    required property ShellScreen modelData

    id: dayDateWindow
    screen: modelData // Set the monitor
    anchors {
      left: true
      right: true
      top: true
    }

    margins {
      top: screen.height * 0.15
    }
    color: "transparent"

    implicitHeight: 256
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: false

    SystemClock {
      id: clock
      precision: SystemClock.Minutes
    }

    Text {
      anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
        topMargin: 32
      }
      text: Time.day

      font.family: "Anurati"
      font.capitalization: Font.AllUppercase
      font.bold: true
      color: Theme.colors.accent
      font.pixelSize: 128
      font.letterSpacing: 24
    }

    Text {
      anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
        bottomMargin: 32
      }
      text: Time.date

      font.family: "Orbitron"
      font.capitalization: Font.AllUppercase
      font.bold: true
      color: Theme.colors.accent
      font.pixelSize: 24
      font.letterSpacing: 11
    }
  }
}
