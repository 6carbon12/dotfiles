import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "../globals"

Rectangle {
  height: 28
  implicitWidth: trayRow.width + 8
  radius: height / 2
  color: Theme.colors.primary
  visible: SystemTray.items.values.length > 0

  RowLayout {
    id: trayRow
    height: parent.height
    anchors.horizontalCenter: parent.horizontalCenter
    uniformCellSizes: true
    spacing: 4

    Repeater {
      model: SystemTray.items

      Rectangle {
        required property SystemTrayItem modelData

        id: trayItem
        Layout.preferredHeight: 16 + 8
        Layout.preferredWidth: 16 + 8
        Layout.alignment: Qt.AlignVCenter
        radius: height / 2
        color: Theme.colors.background

        Image {
          id: trayIcon
          anchors.centerIn: parent
          height: trayItem.height - 8
          width: trayItem.width - 8
          sourceSize.width: width
          sourceSize.height: height
          source: trayItem.modelData.icon
          fillMode: Image.PreserveAspectFit
          layer.enabled: true
        }

        QsMenuAnchor {
          id: trayMenuAnchor
          menu: trayItem.modelData.menu
          anchor {
            item: trayItem
            edges: Edges.Bottom
          }
        }

        MouseArea {
          id: trayArea
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          hoverEnabled: true
          onClicked: (m) => {
            switch (m.button) {
              case Qt.LeftButton:
              trayItem.modelData.activate()
              break;
              case Qt.RightButton:
              trayMenuAnchor.open()
              break;
            }
          }
        }
      }
    }
  }
}
