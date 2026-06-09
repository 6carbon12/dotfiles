import QtQuick
import QtQuick.Layouts
import Quickshell
import "../globals"
import "../components"

PillModule {
  id: wifi
  hasText: false
  paddingX: 18
  spacing: 8

  property bool isConnected: NetworkState.isConnected
  property string signalStrengthIcon: NetworkState.signalStrengthIcon
  property string ssid: NetworkState.ssid
  property string rxSpeed: NetworkState.rxSpeed

  property string icon: (isConnected ? signalStrengthIcon : "disconnected") + ".svg"
  color: isConnected ? Theme.colors.primary : Theme.colors.error

  Image {
    id: wifiIcon
    source: "../assets/network/" + wifi.icon
    cache: false
    Layout.preferredWidth: 16
    Layout.alignment: Qt.AlignVCenter
    sourceSize.width: Layout.preferredWidth
    sourceSize.height: height
    fillMode: Image.PreserveAspectFit

    MouseArea {
      anchors.centerIn: parent
      height: parent.height + 16
      width: parent.width + 16
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        Quickshell.execDetached(["kitty", "--class", "float-term", "--override", "window_padding_width=20", "pulsemixer"])
      }
    }
  }

  Text {
    text: wifi.ssid + " " + wifi.rxSpeed
    font: Theme.mainFont.bold
    color: Theme.colors.background
    Layout.topMargin: 2
  }

  MouseArea {
    // Since parent is RowLayout we bypass that by putting parent as wifi instead
    parent: wifi
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      Quickshell.execDetached(["kitty", "--class", "float-term", "--override", "window_padding_width=20", "impala"])
    }
  }
}
