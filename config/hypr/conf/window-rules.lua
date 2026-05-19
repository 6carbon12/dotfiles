-- Ignore fullscreen requests
hl.window_rule({
  name = "ignore-fullscreen-request",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name = "fix-dragging",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false
  },
  no_focus = true,
})

-- Make float-term windows float and not lose focus
hl.window_rule({
  name = "float-term",
  match = { class = "float-term" },
  float = true,
  size = { 960, 640 },
  center = true,
})

-- Make desktop portal window float
hl.window_rule({
  name = "float-portal",
  match = { class = "xdg-desktop-portal.*" },
  float = true,
  size = { 960, 640 },
  center = true,
})
