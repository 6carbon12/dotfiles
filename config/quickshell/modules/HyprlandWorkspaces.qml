import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../globals"
import "../components"

RowLayout {
  spacing: 8

  Repeater {
    model: Hyprland.workspaces.values 

    Rectangle {
      property bool isSpecial: modelData.name.startsWith("special:")
      property bool isActive: modelData.focused
      property bool isHovered: mouseArea.containsMouse
      property bool isSameMon: (modelData.monitor) && (modelData.monitor.name == bar.monName)

      visible: !isSpecial && isSameMon
      Layout.preferredHeight: 28
      Layout.preferredWidth: isActive ? 44 : 30
      radius: 16 // Exactly half the height guarantees perfect rounded edges

      color: isHovered ? (Theme.darkPurple) : (isActive ? Theme.lightBlue : "transparent")
      border.width: isActive ? 0 : 1
      border.color: isActive ? "transparent" : Theme.lightBlue

      Text {
        anchors.fill: parent
        text: modelData.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: isHovered ? (Theme.text) : (isActive ? Theme.text: Theme.lightBlue)
        font.family: Theme.fontFamily
        font.pixelSize: 14
      }

      MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: modelData.activate()
        cursorShape: Qt.PointingHandCursor
      }
    }
  }
}
