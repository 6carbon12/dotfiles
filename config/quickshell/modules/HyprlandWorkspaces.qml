import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../globals"

RowLayout {
  spacing: 8

  Repeater {
    model: Hyprland.workspaces

    Rectangle {
      id: workspace
      property bool isSpecial: modelData.name.startsWith("special:")
      property bool isActive: modelData.focused
      property bool isHovered: mouseArea.containsMouse
      property bool isSameMon: (modelData.monitor) && (modelData.monitor.name == bar.monName)

      visible: !isSpecial && isSameMon
      Layout.preferredHeight: 28
      Layout.preferredWidth: isActive ? 44 : 30
      radius: height / 2

      color: isHovered ? (Theme.colors.accent) : (isActive ? Theme.colors.primary : "transparent")
      border {
        width: 1
        color: isHovered ? Theme.colors.accent : Theme.colors.primary
      }

      Behavior on Layout.preferredWidth { NumberAnimation { duration: 150; } }
      Behavior on color { ColorAnimation { duration: 150; } }

      // Opening Animation
      scale: 0
      opacity: 0

      ParallelAnimation {
        id: entryAnim
        NumberAnimation { target: workspace; property: "opacity"; to: 1.0; duration: 200 }
        NumberAnimation { target: workspace; property: "scale"; to: 1.0; duration: 200 }
      }

      Component.onCompleted: entryAnim.start()

      Text {
        anchors.fill: parent
        text: modelData.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: isHovered ? (Theme.colors.background) : (isActive ? Theme.colors.background: Theme.colors.primary)
        font: Theme.mainFont.normal
        Behavior on color { ColorAnimation {duration: 150; } }
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
