import QtQuick 
import QtQuick.Layouts
import Quickshell 
import Quickshell.Hyprland
import "../globals"

// Shows ● when there are any windows in minimized workspace
Text {
  id: minimizedIndicator
  text: "●"
  color: Theme.lightBlue
  font.pixelSize: 14
  Layout.preferredWidth: 14
  property bool hasMinimized: HyprlandState.hasMinimized
  visible: hasMinimized

  MouseArea {
    anchors.fill: parent
    anchors.margins: -8 
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.workspace.toggle_special('minimized')"])
    }
  }
}
