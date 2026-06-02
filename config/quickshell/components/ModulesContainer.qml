import QtQuick
import QtQuick.Layouts
import "../globals"

Rectangle {
  id: root

  default property alias innerContent: mainLayout.data

  property int paddingX: 0
  property int paddingY: 0
  property alias spacing: mainLayout.spacing
  property int innerHeight: height - (paddingY * 2)

  width: mainLayout.implicitWidth + (paddingX * 2)
  radius: 32
  color: Qt.alpha(Theme.colors.background, Theme.bgOpacity)

  RowLayout {
    id: mainLayout
    height: parent.innerHeight
    anchors.centerIn: parent
    spacing: 0
  }
}
