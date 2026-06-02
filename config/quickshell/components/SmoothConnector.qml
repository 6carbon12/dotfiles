import QtQuick
import Quickshell
import "../globals"

Item {
  id: root
  height: parent.height
  property real alpha: Theme.bgOpacity
  Image {
    id: leftConnector
    anchors.left: parent.left
    width: 40
    height: width
    fillMode: Image.PreserveAspectFit
    source: "file://" + Quickshell.shellDir + "/assets/connector.svg"
    opacity: root.alpha
  }

  Rectangle {
    height: 6
    anchors.verticalCenter: root.verticalCenter
    anchors.left: leftConnector.right
    anchors.right: rightConnector.left
    anchors.verticalCenterOffset: -1
    anchors.leftMargin: -2
    anchors.rightMargin: -2
    color: Qt.alpha(Theme.colors.background, root.alpha)
  }

  Image {
    id: rightConnector
    anchors.right: parent.right
    width: 40
    height: width
    fillMode: Image.PreserveAspectFit
    source: "file://" + Quickshell.shellDir + "/assets/connector.svg"
    mirror: true
    opacity: root.alpha
  }
}
