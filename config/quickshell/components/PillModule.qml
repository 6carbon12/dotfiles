import QtQuick
import QtQuick.Layouts
import "../globals"

Rectangle {
  id: root
  Layout.preferredWidth: mainLayout.implicitWidth + (paddingX * 2)
  height: 28
  radius: 32

  default property alias innerContent: mainLayout.data

  property int paddingX: 0
  property int paddingY: 0
  property alias spacing: mainLayout.spacing
  property alias displayText: mainLayout.text
  property alias hasText: mainLayout.hasText

  RowLayout {
    id: mainLayout
    anchors.centerIn: parent 
    spacing: 0
    property alias text: mainText.text
    property int pWidth
    property bool hasText: true

    Text {
      id: mainText
      color: Theme.text
      visible: parent.hasText
      Layout.topMargin: 2
      font {
        family: Theme.fontFamily
        pixelSize: 14
        weight: Font.Bold
      }

    }
  }
}
