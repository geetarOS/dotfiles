-- Noctalia color scheme (translated to Lua)
local primary        = "rgb(e4a767)"
local surface        = "rgb(241f19)"
local secondary      = "rgb(d6d65c)"
local error_col      = "rgb(c58a56)"
local tertiary       = "rgb(98cc66)"  -- defined but unused in original
local surface_lowest = "rgb(120f0c)"  -- defined but unused in original

hl.config({
  general = {
    col = {
      active_border   = primary,
      inactive_border = surface,
    },
  },
  group = {
    col = {
      border_active          = secondary,
      border_inactive        = surface,
      border_locked_active   = error_col,
      border_locked_inactive = surface,
    },
    groupbar = {
      col = {
        active          = secondary,
        inactive        = surface,
        locked_active   = error_col,
        locked_inactive = surface,
      },
    },
  },
})
