hl.config({
  decoration = {
    rounding = 8,
    rounding_power = 3,

    active_opacity = 0.9,
    inactive_opacity = 0.8,
    fullscreen_opacity = 1.0,

    blur = {
      enabled = true,
      size = 6,
      noise = 0.0,
      passes = 3,
      new_optimizations = true,
      contrast = 1.05,
      brightness = 0.7,
      vibrancy = 0.1,
      ignore_opacity=true,
      xray = true,
      popups = true,
    },

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "#000000aa",
    },
  }
})
