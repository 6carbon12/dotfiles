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

      color: isHovered ? (Theme.colors.accent) : (isActive ? Theme.colors.primary : "transparent")
      border.width: (isActive || isHovered) ? 0 : 1
      border.color: (isActive || isHovered) ? "transparent" : Theme.colors.primary

      Text {
        anchors.fill: parent
        text: modelData.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: isHovered ? (Theme.colors.background) : (isActive ? Theme.colors.background: Theme.colors.primary)
        font: Theme.mainFont.normal
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
