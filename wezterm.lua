local wezterm = require("wezterm")

local bg_image = "/home/jboyett/Pictures/backgrounds/png_images/current.png"
wezterm.add_to_config_reload_watch_list(bg_image)

local function get_bg() -- I want the background to be different if I'm in AwesomeWM
  local desktop = os.getenv("GDMSESSION")
  if desktop == "awesome" then
    return {
      {
        source = {
          -- File = bg_image,
          Color = "black",
        },
        attachment = "Fixed",
        height = "100%",
        width = "100%",
        repeat_x = "NoRepeat",
        repeat_y = "NoRepeat",
        hsb = {
          brightness = 0.1,
        },
        opacity = 0.75,
      },
    }
  else
    return {
      {
        source = {
          File = bg_image,
        },
        attachment = "Fixed",
        height = "100%",
        width = "100%",
        repeat_x = "NoRepeat",
        repeat_y = "NoRepeat",
        hsb = {
          brightness = 0.1,
        },
      },
    }
  end
end

return {
  font = wezterm.font("CaskaydiaCove NF"),
  font_rules = {
    {
      font = wezterm.font("CaskaydiaCove NF"),
      italic = false,
    },
    {
      font = wezterm.font("OperatorMono-BoldItalic"),
      italic = true,
    },
  },

  font_size = 16.0,
  hide_tab_bar_if_only_one_tab = true,
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    {
      key = "v",
      mods = "LEADER",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
      key = "E",
      mods = "CTRL",
      action = wezterm.action.EmitEvent("toggle-ligature"),
    },
  },
  audible_bell = "Disabled",
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },
  background = get_bg(),
  wezterm.on("toggle-ligature", function(window, pane)
    local overrices = window:get_config_overrides() or {}
    if not overrices.harfbuzz_features then
      overrices.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
    else
      overrices.harfbuzz_features = nil
    end
    window:set_config_overrides(overrices)
  end),
}
