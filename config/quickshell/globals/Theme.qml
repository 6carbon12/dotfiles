pragma Singleton
import Quickshell
import QtQuick

Singleton {
  id: theme

  readonly property QtObject mainFont: QtObject {
    readonly property font normal: Qt.font({
      family: "JetBrainsMono Nerd Font",
      pixelSize: 14
    })
    readonly property font bold: Qt.font({
      family: "JetBrainsMono Nerd Font",
      pixelSize: 14,
      bold: true
    })
    readonly property font italic: Qt.font({
      family: "JetBrainsMono Nerd Font",
      pixelSize: 14,
      italic: true
    })
  }

  readonly property QtObject palette: QtObject {
    readonly property color neutral100: "#c0caf5"
    readonly property color neutral200: "#a9b1d6"
    readonly property color neutral300: "#8c96c6"
    readonly property color neutral400: "#737aa2"
    readonly property color neutral500: "#565f89"
    readonly property color neutral600: "#414868"
    readonly property color neutral700: "#292e42"
    readonly property color neutral800: "#24283b"
    readonly property color neutral900: "#1a1b26"

    readonly property color red:   "#ff757f"
    readonly property color orange: "#ff9e64"
    readonly property color yellow: "#ffc777"
    readonly property color green:  "#c3e88d"
    readonly property color teal:   "#4fd6be"
    readonly property color blue:   "#7aa2f7"
    readonly property color purple: "#bb9af7"
    readonly property color pink: "#ff007c"
  }

  readonly property QtObject colors: QtObject {
    readonly property color background: theme.palette.neutral900
    readonly property color foreground: theme.palette.neutral100
    readonly property color primary:    theme.palette.blue
    readonly property color accent:     theme.palette.purple

    readonly property color disabled:   theme.palette.neutral400
    readonly property color success:    theme.palette.green
    readonly property color warning:    theme.palette.yellow
    readonly property color error:      theme.palette.red
    readonly property color danger:      theme.palette.red
  }

  readonly property real bgOpacity: 0.7
}
