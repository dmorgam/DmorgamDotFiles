------------------------------------
--    Dmorgam hyprland config     --
------------------------------------
--
-- Formato Lua (Hyprland 0.56+). El formato .conf queda sin soporte en 0.57.
-- El antiguo hyprland.conf esta borrado; si hace falta consultarlo:
--   git show 7a546f9:config/hypr/hyprland.conf
--
-- Stubs para el LSP (lua_ls): /usr/share/hypr/stubs/hl.meta.lua
-- Ejemplo upstream:           /usr/share/hypr/hyprland.lua

-- -- Theme -------------------------------------

local c = require("theme")

-- -- Monitors ----------------------------------

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Home setup
hl.monitor({ output = "desc:LG Display",                          mode = "1920x1080", position = "0x0",        scale = 1 })
hl.monitor({ output = "desc:LG Electronics LG FHD",               mode = "1920x1080", position = "-960x-1080", scale = 1 })
hl.monitor({ output = "desc:Samsung Electric Company LF24T35",    mode = "1920x1080", position = "960x-1080",  scale = 1 })

-- Alt Home setup
-- The Left monitor is same model as Left monitor in main home setup
-- LG old right
hl.monitor({ output = "desc:LG Electronics L1718S",               mode = "1280x1024", position = "960x-1024",  scale = 1 })

-- -- Default Programs --------------------------

local terminal    = "kitty"
local menu        = "rofi -show run"
local fileManager = "kitty --single-instance ranger"
local logout      = "wlogout &"

-- -- Autostart ---------------------------------

hl.on("hyprland.start", function()
    -- Theme
    hl.exec_cmd("hyprctl setcursor capitaine-cursors 32")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")

    -- Tools
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("waybar")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("udiskie --appindicator -t")
    hl.exec_cmd("blueman-applet")

    -- Workaround Hyprland 0.55 monitor geometry race: cursor confinado al inicio.
    -- Pendiente de comprobar si 0.56 ya lo corrige; si al quitarlo los monitores
    -- salen bien tras el login, se puede borrar esta linea.
    -- Ref: https://github.com/hyprwm/Hyprland/discussions/10969
    hl.exec_cmd("sleep 2 && hyprctl reload")

    -- Auto apps
    hl.exec_cmd("kitty --title 'Developer' tmux-coding-session.sh", { workspace = "1 silent" })
    -- hl.exec_cmd("kitty --title 'Neomutt' ~/.config/mutt/tmux.sh", { workspace = "4 silent" })
    hl.exec_cmd("firefox", { workspace = "2 silent" })
end)

-- -- Enviroment variables ----------------------

hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_SIZE", "16")
hl.env("EDITOR", "nvim")
hl.env("GTK_THEME", "Adwaita:dark")

-- -- Look and feel -----------------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 0,

        col = {
            active_border   = c.lavender,
            inactive_border = c.overlay1,
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "dwindle",
    },

    cursor = {
        inactive_timeout = 3,
    },

    decoration = {
        rounding = 20,

        active_opacity   = 1.0,
        inactive_opacity = 0.7,

        dim_inactive = true,
        dim_strength = 0.30,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            -- rgba(1a1a1aee) en .conf: en Lua el alpha va delante (AARRGGBB).
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size    = 3,
            passes  = 1,

            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    group = {
        auto_group = false,
        groupbar = {
            enabled = false,
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint",  style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",        style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear",  style = "fade" })

-- -- Input -------------------------------------

hl.config({
    input = {
        kb_layout  = "us,es",
        kb_variant = "",
        kb_model   = "",
        kb_rules   = "",
        left_handed = true,

        -- Key layout switch and remap caplock to ctl
        kb_options = "grp:win_space_toggle, ctrl:nocaps",

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- -- Keybindings -------------------------------

-- Sets "Windows" key as main modifier
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(logout))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())            -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))      -- dwindle
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
local notify = "$HOME/.local/bin/hyprland-notifications.sh"
local mediaOpts = { locked = true, repeating = true }

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(notify .. " audio 5%+"),  mediaOpts)
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(notify .. " audio 5%-"),  mediaOpts)
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(notify .. " audio mute"), mediaOpts)
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(notify .. " mic mute"),   mediaOpts)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(notify .. " light 10%+"), mediaOpts)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(notify .. " light 10%-"), mediaOpts)

-- -- Windows and workspaces --------------------

-- Ignore maximize requests from apps.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "no_focus",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_initial_focus = true,
})

-- Custom workspace layout for home setup
hl.workspace_rule({ workspace = "1", default = true, monitor = "desc:LG Electronics LG FHD" })
hl.workspace_rule({ workspace = "2", default = true, monitor = "desc:Samsung Electric Company LF24T35" })
hl.workspace_rule({ workspace = "3", default = true, monitor = "desc:LG Electronics LG FHD" })
hl.workspace_rule({ workspace = "4", default = true, monitor = "desc:LG Display" })
