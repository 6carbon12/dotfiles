pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  // The global properties your UI will bind to
  property string ssid: "Searching..."
  property bool isConnected: ssid !== "" && ssid !== "Searching..." && ssid !== "Disconnected"
  property string rxSpeed: "  0.0 KB/s"
  property int signalStrength: 0
  property string signalStrengthIcon: "low"

  // Formatting function
  function formatSpeed(bytes) {
    const k = 1000;
    if (isNaN(bytes) || bytes <= 0 || bytes < k) return "  0.0 KB/s";

    const sizes = ['KB/s', 'MB/s', 'GB/s', 'TB/s'];
    const i = Math.floor(Math.log(bytes) / Math.log(k)) - 1;

    let numStr = (bytes / Math.pow(k, i + 1)).toFixed(1);

    while (numStr.length < 5) {
      numStr = "\u00A0" + numStr;
    }

    return numStr + " " + sizes[i];
  }

  Process {
    id: wifiProc
    command: ["iwgetid", "-r", "wlan0"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let output = this.text.trim();
        root.ssid = output !== "" ? output : "Disconnected";
      }
    }
  }

  Process {
    id: wifiIconProc
    command: ["iw", "dev", "wlan0", "link"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const output = this.text;

        const match = output.match(/signal:\s+(-?\d+)\s+dBm/);

        if (match && match[1]) {
          // Convert the captured string to an integer
          root.signalStrength = parseInt(match[1], 10);

          // Categorize into High, Mid, or Low stages
          if (root.signalStrength >= -60) {
            root.signalStrengthIcon = "high";
          } else if (root.signalStrength >= -75) {
            root.signalStrengthIcon = "mid";
          } else {
            root.signalStrengthIcon = "low";
          }

          console.log("Processed Signal: " + root.signalStrength + " dBm (" + root.signalStrengthIcon + ")");
        }
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: wifiIconProc.running = true
  }

  Process {
    id: wifiMonitor
    command: ["iw", "event"]
    running: true

    stdout: SplitParser {
      onRead: (data) => {
        wifiProc.running = true;
        wifiIconProc.running = true;
      }
    }
    onRunningChanged: {
      if (!running) running = true;
    }
  }

  Process {
    id: speedMonitor
    command: [
      "bash", "-c",
      "read rx1 < /sys/class/net/wlan0/statistics/rx_bytes 2>/dev/null || rx1=0; while sleep 2; do read rx2 < /sys/class/net/wlan0/statistics/rx_bytes 2>/dev/null || rx2=0; echo $(((rx2-rx1)/2)); rx1=$rx2; done"
    ]
    running: true

    stdout: SplitParser {
      onRead: (data) => {
        let speedStr = data.trim();
        if (speedStr !== "") {
          root.rxSpeed = root.formatSpeed(parseInt(speedStr));
        }
      }
    }
    onRunningChanged: { if (!running) running = true; }
  }
}
