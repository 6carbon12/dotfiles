-- Minimized workspace rules
hl.workspace_rule({
  workspace = "special:minimized",
  gaps_out = 256,
  border_size = 1,
  layout = "scrolling",
})

-- Scrolling on 2nd workspace
hl.workspace_rule({
  workspace = "2",
  layout = "scrolling",
})

hl.workspace_rule({
  workspace = "11",
  monitor = "eDP-1",
  default = true,
})
