pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string time: { Qt.formatDateTime(clock.date, "hh:mm AP") }
  readonly property string day: { Qt.formatDate(clock.date, "dddd") }
  readonly property string date: { Qt.formatDate(clock.date, "dd MMMM yyyy") }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
