hl.config({
  binds = {
    hide_special_on_workspace_change = true,
    window_direction_monitor_fallback = false,
  }
})

local mainMod = "SUPER"
local terminal = "kitty"
local browser = "firefox"
local app_launcher = "~/.local/bin/arka"

-- Launch apps
hl.bind(mainMod .. "+ Return", hl.dsp.exec_cmd("gtk-launch " .. terminal))
hl.bind(mainMod .. "+ B", hl.dsp.exec_cmd("gtk-launch " .. browser))
hl.bind(mainMod .. "+ P", hl.dsp.exec_cmd(app_launcher))

-- Launch utilitlies
hl.bind(mainMod .. "+ W", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | tesseract - stdout | wl-copy]]))
hl.bind(mainMod .. "+ space", hl.dsp.exec_cmd(terminal .. " --class float-term clipse"))
hl.bind(mainMod .. "+ PERIOD", hl.dsp.exec_cmd("emote"))

-- Screenshoting
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))
hl.bind("XF86Launch7", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- Window actions
hl.bind(mainMod .. "+ X", hl.dsp.window.close())
hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.window.float({action = "toggle"}))

-- Moving Focus
hl.bind(mainMod .. "+ H", hl.dsp.focus({ direction = "l"}))
hl.bind(mainMod .. "+ L", hl.dsp.focus({ direction = "r"}))
hl.bind(mainMod .. "+ K", hl.dsp.focus({ direction = "u"}))
hl.bind(mainMod .. "+ J", hl.dsp.focus({ direction = "d"}))

hl.bind(mainMod .. "+ left",  hl.dsp.focus({ direction = "l"}))
hl.bind(mainMod .. "+ right", hl.dsp.focus({ direction = "r"}))
hl.bind(mainMod .. "+ up",    hl.dsp.focus({ direction = "u"}))
hl.bind(mainMod .. "+ down",  hl.dsp.focus({ direction = "d"}))

-- Moving Windows (within workspaces)
hl.bind(mainMod .. "+ SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. "+ SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. "+ SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. "+ SHIFT + J", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. "+ SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. "+ SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. "+ SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. "+ SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Switching workspaces
hl.bind(mainMod .. "+ 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. "+ 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. "+ 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. "+ 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. "+ 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. "+ 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. "+ 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. "+ 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. "+ 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. "+ 0", hl.dsp.focus({ workspace = 10 }))

-- Moving Windows (across workspaces)
hl.bind(mainMod .. "+ SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. "+ SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. "+ SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. "+ SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. "+ SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. "+ SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. "+ SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. "+ SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. "+ SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. "+ SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. "+ CTRL + 1", hl.dsp.window.move({ workspace = 1,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 2", hl.dsp.window.move({ workspace = 2,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 3", hl.dsp.window.move({ workspace = 3,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 4", hl.dsp.window.move({ workspace = 4,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 5", hl.dsp.window.move({ workspace = 5,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 6", hl.dsp.window.move({ workspace = 6,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 7", hl.dsp.window.move({ workspace = 7,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 8", hl.dsp.window.move({ workspace = 8,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 9", hl.dsp.window.move({ workspace = 9,  follow = false}))
hl.bind(mainMod .. "+ CTRL + 0", hl.dsp.window.move({ workspace = 10, follow = false }))

-- Moving Windows (using mouse)
hl.bind(mainMod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Multimedia
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), {
    repeating = true, locked = true
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
    repeating = true, locked = true
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
    repeating = true, locked = true
})
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
    repeating = true, locked = true
})
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), {
   locked = true
})
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), {
   locked = true
})
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), {
   locked = true
})


-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[~/.dotfiles/config/hypr/scripts/brightness.sh "+"]]), {
   repeating = true, locked = true
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[~/.dotfiles/config/hypr/scripts/brightness.sh "-"]]), {
   repeating = true, locked = true
})
hl.bind(mainMod .. "+ bracketright", hl.dsp.exec_cmd([[~/.dotfiles/config/hypr/scripts/brightness.sh "+"]]), {
   repeating = true, locked = true
})
hl.bind(mainMod .. "+ bracketleft", hl.dsp.exec_cmd([[~/.dotfiles/config/hypr/scripts/brightness.sh "-"]]), {
   repeating = true, locked = true
})

-- Minimization Solution
hl.bind(mainMod .. "+ M", hl.dsp.window.move({workspace = "special:minimized", follow = false}))
hl.bind(mainMod .. "+ SHIFT + M", hl.dsp.workspace.toggle_special("minimized"))

-- Toggling internal monitor
hl.bind(mainMod .. "+ ALT + D", function ()
  local mons = hl.get_monitors()
  for _, mon in ipairs(mons) do
    if mon.name == "eDP-1" then
      hl.monitor({
        output = "eDP-1",
        disabled = true
      })
      return
    end
  end

  hl.monitor({
    output = "eDP-1",
    disabled = false,
    mode = "preferred",
    position = "auto",
    scale = "1",
  })
end
)

-- Left SUPER will move the cursor to bottom right
hl.bind("SUPER + SUPER_L", function ()
  local width = hl.get_active_monitor().width
  local height = hl.get_active_monitor().height

  hl.dispatch(hl.dsp.cursor.move({ x = width, y = height}))
end,
{ release = true })

-- Backup script
hl.bind(mainMod .. "+ SHIFT + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/bkup.sh"))

-- SUBMAPS:
-- Dashboard

hl.bind(mainMod .. "+ D", function ()
  hl.dispatch(hl.dsp.submap("dashboard"))
  hl.dispatch(hl.dsp.exec_cmd("eww open-many dashboard-main dashboard-external --toggle"))
end)

local function is_inside(px, py, x, y, w, h)
  return (x <= px and px <= x + w) and (y <= py and py <= y + h)
end

hl.define_submap("dashboard", function ()
  hl.bind("Space", hl.dsp.exec_cmd("playerctl play-pause"))
  hl.bind("Return", hl.dsp.exec_cmd("playerctl play-pause"))

  hl.bind("N", hl.dsp.exec_cmd("playerctl next"))
  hl.bind("L", hl.dsp.exec_cmd("playerctl next"))
  hl.bind("K", hl.dsp.exec_cmd("playerctl next"))
  hl.bind("right", hl.dsp.exec_cmd("playerctl next"))
  hl.bind("period", hl.dsp.exec_cmd("playerctl next"))

  hl.bind("P", hl.dsp.exec_cmd("playerctl previous"))
  hl.bind("H", hl.dsp.exec_cmd("playerctl previous"))
  hl.bind("J", hl.dsp.exec_cmd("playerctl previous"))
  hl.bind("left", hl.dsp.exec_cmd("playerctl previous"))
  hl.bind("comma", hl.dsp.exec_cmd("playerctl previous"))

  hl.bind("catchall", function ()
    hl.dispatch(hl.dsp.submap("reset"))
    hl.dispatch(hl.dsp.exec_cmd("eww open-many dashboard-main dashboard-external --toggle"))
  end)

  hl.bind("mouse:272", function ()
    local layers = hl.get_layers();
    for _, layer in ipairs(layers) do
      local active_mon = hl.get_active_monitor()
      -- hl.notification.create({text = "active mon: " .. active_mon.name .. "\nlayer monitor: " .. layer.monitor, timeout = 3000})
      if layer.layer ~= 3 or (active_mon and layer.monitor.name ~= active_mon.name) then
        goto continue
      end

      local cursor_pos = hl.get_cursor_pos()

      if cursor_pos and (not is_inside(cursor_pos.x, cursor_pos.y, layer.x, layer.y, layer.w, layer.h)) then
        hl.dispatch(hl.dsp.submap("reset"))
        hl.dispatch(hl.dsp.exec_cmd("eww open-many dashboard-main dashboard-external --toggle"))
      end
      ::continue::
    end
  end,{ mouse = true, non_consuming = true })
end)
