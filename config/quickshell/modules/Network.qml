import QtQuick
import QtQuick.Layouts
import Quickshell
import "../globals"
import "../components"

PillModule {
  id: wifiPill
  paddingX: 18

  property bool isConnected: NetworkState.isConnected
  property string ssid: NetworkState.ssid
  property string rxSpeed: NetworkState.rxSpeed

  color: isConnected ? Theme.colors.primary : Theme.colors.error
  property string icon: isConnected ? "󰖩 " : "󰖪 "

  displayText: icon + ssid + " " + rxSpeed

  MouseArea {
    // Since parent is RowLayout we bypass that by putting parent as wifiPill instead
    parent: wifiPill
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      Quickshell.execDetached(["kitty", "--class", "float-term", "--override", "window_padding_width=20", "impala"])
    }
  }
}
