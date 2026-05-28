pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
  id: root
  property bool hasMinimized: false

  function checkMinimized() {
    let workspaces = Hyprland.workspaces.values;
    let found = false;

    for (let i = 0; i < workspaces.length; i++) {
      if (workspaces[i].name === "special:minimized") {
        found = true
        break;
      }
    }

    root.hasMinimized = found;
  }

  Component.onCompleted: root.checkMinimized()

  Connections {
    target: Hyprland
    function onRawEvent(name, data) {
      Qt.callLater(root.checkMinimized)
    }
  }
}
