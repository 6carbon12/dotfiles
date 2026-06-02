import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "globals"
import "components"
import "modules"

// TODO: Add ANIMATIONS

// Creates a PanelWindow for each item in Quickshell.screens 
// And exposes the `screen` to PanelWindow as `modelData`
Variants {
  model: Quickshell.screens

  PanelWindow {
    required property ShellScreen modelData

    id: bar
    anchors {
      left: true
      top: true
      right: true
    }
    implicitHeight: 42
    color: "transparent"
    screen: modelData // Set the monitor

    property string monName: modelData ? modelData.name : null
    property int connectingBarHeight: 4

    ModulesContainer {
      id: modulesLeft
      anchors {
        left: parent.left
        top: parent.top
        leftMargin: 2
        topMargin: 2
      }

      paddingX: 8
      spacing: 12
      height: parent.height - 2

      // TODO: Rewrite dashboard in Quickshell
      Rectangle {
        id: dashboardToggle
        height: 20 + 8
        width: 20 + 32
        color: Theme.colors.primary
        radius: height / 2
        Image {
          id: archLogo
          source: "./assets/arch-logo.svg"
          sourceSize: Qt.size(20, 20)
          fillMode: Image.PreserveAspectFit
          anchors.centerIn: parent
          MouseArea {
            parent: dashboardToggle
            anchors.fill: parent
            onClicked: {
              Quickshell.execDetached(["eww", "open-many", "dashboard-main", "--toggle"])
            }
          }
        }
      }
      HyprlandMinimizedIndicator {}
    }

    SmoothConnector {
      anchors {
        left: modulesLeft.right
        right: modulesCenter.left
        top: parent.top
        leftMargin: -22
        rightMargin: -22
        topMargin: 2
      }
    }

    ModulesContainer {
      id: modulesCenter
      anchors {
        top: parent.top 
        horizontalCenter: parent.horizontalCenter
        topMargin: 2
      }
      paddingX: 7
      paddingY: 0
      height: parent.height - 2


      // TODO: Add animations
      HyprlandWorkspaces {}
    }

    SmoothConnector {
      anchors {
        left: modulesCenter.right
        right: modulesRight.left
        top: parent.top
        leftMargin: -22
        rightMargin: -22
        topMargin: 2
      }
    }

    ModulesContainer {
      id: modulesRight
      anchors {
        right: parent.right
        top: parent.top
        rightMargin: 2
        topMargin: 2
      }
      height: parent.height - 2
      paddingX: 7
      spacing: 8

      Volume {}
      Network {}

      PillModule {
        id: battery
        paddingX: 12

        function formatSeconds(secs) {
          let hours = Math.floor(secs / 3600);
          let minutes = Math.floor((secs % 3600) / 60);

          // Pad with leading zeros using helper or string methods
          let hh = hours.toString().padStart(2, '0');
          let mm = minutes.toString().padStart(2, '0');

          return hh + ":" + mm;
        }

        property var bat: UPower.displayDevice
        property int percent: bat ? Math.round(bat.percentage * 100) : 0
        property bool isCharging: bat && bat.state === UPowerDeviceState.Charging
        property bool isDisCharging: bat.state === UPowerDeviceState.Discharging
        property bool isOnAC: !isCharging && !isDisCharging // When laptop is running off of AC
        property bool isFull: bat.state === UPowerDeviceState.FullyCharged
        property bool isCritical: percent <= 15 && !isCharging
        property string icon: {
          if (isCharging) { return "󰂄" } 
          if (isOnAC) { return "" }
          if (percent >= 90) { return "󰂂" }
          if (percent >= 80) { return "󰂁" }
          if (percent >= 70) { return "󰂀" }
          if (percent >= 60) { return "󰁿" }
          if (percent >= 50) { return "󰁾" }
          if (percent >= 40) { return "󰁽" }
          if (percent >= 30) { return "󰁼" }
          if (percent >= 20) { return "󰁻" }
          if (percent >= 10) { return "󰁺" }
          if (percent >= 0) { return "󰂎" }
        }
        property bool isClicked: false 
        property string textMain: icon + " " + percent + "%"
        property string textAlt: (isOnAC ? " " : formatSeconds((isCharging ? bat.timeToFull : bat.timeToEmpty))) + " h -- " + bat.changeRate + " W"

        color: isCritical ? Theme.colors.danger : Theme.colors.primary
        displayText: isClicked ? textAlt : textMain

        MouseArea {
          id: batteryMouseArea
          parent: battery 
          anchors.fill: parent

          onClicked: {
            battery.isClicked = !battery.isClicked
          }
        }
      }

      // TODO: Show a custom made calender widget when clicked
      PillModule {
        id: clock
        paddingX: 12
        displayText: Time.time
        color: Theme.colors.primary
      }
    }
  }
}
