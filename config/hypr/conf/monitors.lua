-- External Monitor
hl.monitor({
  output = "DP-1",
  mode = "3440x1440@180",
  position = "0x0",
})

-- Internal Monitor
hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = "1",
})

-- Add monitor
hl.on("monitor.added", function(_)
  -- reload eww when new monitor is added
  hl.exec_cmd("touch ~/.config/eww/eww.yuck")
end)
