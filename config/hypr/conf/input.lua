hl.config({
  input = {
    repeat_delay = 250,
    repeat_rate = 25,
    follow_mouse = 1,

    scroll_method = "2fg",
    kb_options = "caps:swapescape",

    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      drag_lock = 1,
    },

    touchdevice = {
      enabled = false,
    },
  }
})

hl.device({
  name = "optimus-bt1-keyboard",
  kb_options = "altwin:swap_lalt_lwin,caps:swapescape,ctrl:ralt_rctrl",
})
