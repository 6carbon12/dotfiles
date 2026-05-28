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
    id: wifiMonitor
    command: ["iw", "event"]
    running: true

    stdout: SplitParser {
      onRead: (data) => {
        wifiProc.running = true;
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
