hl.config({
  general = {
    border_size = 1,
    gaps_in = 4,
    gaps_out = {
      top = 8,
      bottom = 8,
      left = 4,
      right = 4,
    },

    col = {
      inactive_border = "#595959AA",
      active_border = {
        colors = {
          "#7aa2f7ff",
          "#a88adeff",
        },
        angle = 45,
      },
    },

    resize_on_border = true,
    extend_border_grab_area = 0,

    layout = "master",
  },
})
