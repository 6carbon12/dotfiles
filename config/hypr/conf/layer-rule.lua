-- Don't animate grim and slurp so screenshots don't get ruined
hl.layer_rule({
    name = "noanim-selection",
    match = { namespace = "selection" },
    no_anim = true,
})

-- Add Blur background to waybar
hl.layer_rule({
    name = "blur-waybar",
    match = { namespace = "waybar" },
    blur = true,
})

-- Dim background on launcher
hl.layer_rule({
    name = "dimaround-launcher",
    match = { namespace = "launcher" },
    dim_around = true,
})

-- Enable seeing notifications on the lockscreen
hl.layer_rule({
    name = "abovelock-notifcations",
    match = { namespace = "notifications" },
    above_lock = true,
})
