# Traducción de config-nueva al formato de nix-wrapper-modules
# Solo incluye lo que difiere o no existe en el default config de niri
# Omite: input, outputs (se configuran por separado)

settings = {

  spawn-at-startup = [
    [ "nmcli" "radio" "wifi" "on" ]
  ];

  environment = {
    XDG_CURRENT_DESKTOP = "niri";
  };

  config-notification.disable-failed = _: {};

  screenshot-path = "~/Pictures/Capturas de pantalla/Screenshot from %Y-%m-%d %H-%M-%S.png";

  prefer-no-csd = _: {};

  hotkey-overlay.skip-at-startup = _: {};

  gestures.hot-corners.off = _: {};

  overview.workspace-shadow.off = _: {};

  debug.honor-xdg-activation-with-invalid-serial = _: {};

  layout = {
    # gaps no está definido en config-nueva, hereda el default (16)
    # center-focused-column igual al default ("never"), no se sobreescribe
    # preset-column-widths igual al default, no se sobreescribe
    # default-column-width igual al default, no se sobreescribe

    background-color = "transparent";  # nuevo, no está en default

    # focus-ring no está en config-nueva → usa el default

    border = {
      off = _: {};
      width = 4;
      active-color   = "#707070";
      inactive-color = "#d0d0d0";
      urgent-color   = "#cc4444";
    };

    shadow = {
      softness = 30;
      spread = 5;
      offset = _: { props = { x = 0; y = 5; }; };
      color = "#0007";
    };

    struts = {};
  };

  animations = {
    workspace-switch = {
      spring = _: { props = { damping-ratio = 0.80; stiffness = 523; epsilon = 0.0001; }; };
    };
    window-open = {
      duration-ms = 150;
      curve = "ease-out-expo";
    };
    window-close = {
      duration-ms = 150;
      curve = "ease-out-quad";
    };
    horizontal-view-movement = {
      spring = _: { props = { damping-ratio = 0.85; stiffness = 423; epsilon = 0.0001; }; };
    };
    window-movement = {
      spring = _: { props = { damping-ratio = 0.75; stiffness = 323; epsilon = 0.0001; }; };
    };
    window-resize = {
      spring = _: { props = { damping-ratio = 0.85; stiffness = 423; epsilon = 0.0001; }; };
    };
    config-notification-open-close = {
      spring = _: { props = { damping-ratio = 0.65; stiffness = 923; epsilon = 0.001; }; };
    };
    screenshot-ui-open = {
      duration-ms = 200;
      curve = "ease-out-quad";
    };
    overview-open-close = {
      spring = _: { props = { damping-ratio = 0.85; stiffness = 800; epsilon = 0.0001; }; };
    };
  };

  layer-rules = [
    {
      matches = [{ namespace = "^quickshell$"; }];
      place-within-backdrop = true;
    }
  ];

  window-rules = [
    # Del default — WezTerm fix
    {
      matches = [{ app-id = "^org\\.wezfurlong\\.wezterm$"; }];
      default-column-width = _: {};
    }
    # Nuevas reglas
    {
      matches = [{ app-id = "^org\\.gnome\\."; }];
      draw-border-with-background = false;
      geometry-corner-radius = 12;
      clip-to-geometry = true;
    }
    {
      matches = [
        { app-id = "^gnome-control-center$"; }
        { app-id = "^pavucontrol$"; }
        { app-id = "^nm-connection-editor$"; }
      ];
      default-column-width = _: { content.proportion = 0.5; };
      open-floating = false;
    }
    {
      matches = [
        { app-id = "org.gnome.Calculator"; }
        { app-id = "^galculator$"; }
        { app-id = "^blueman-manager$"; }
        { app-id = "org.gnome.NautilusPreviewer"; }
        { app-id = "^xdg-desktop-portal$"; }
      ];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^steam$"; title = "^notificationtoasts_\\d+_desktop$"; }];
      default-floating-position = _: { props = { x = 10; y = 10; relative-to = "bottom-right"; }; };
      open-focused = false;
    }
    {
      matches = [
        { app-id = "^org\\.wezfurlong\\.wezterm$"; }
        { app-id = "Alacritty"; }
        { app-id = "zen"; }
        { app-id = "com.mitchellh.ghostty"; }
        { app-id = "kitty"; }
      ];
      draw-border-with-background = false;
    }
    {
      matches = [
        { app-id = "firefox$"; title = "^Picture-in-Picture$"; }
        { app-id = "zen"; title = "^Picture-in-Picture$"; }
      ];
      open-floating = true;
      default-column-width = _: { content.fixed = 640; };
      default-window-height = _: { content.fixed = 360; };
    }
    {
      matches = [
        { app-id = "org.quickshell$"; }
        { app-id = "com.danklinux.dms$"; }
      ];
      open-floating = true;
    }
  ];

  # recent-windows con binds propios (reemplaza el Alt+Tab por defecto)
  recent-windows.binds = {
    "Alt+Tab"         = { next-window     = _: { props.scope = "output"; }; };
    "Alt+Shift+Tab"   = { previous-window = _: { props.scope = "output"; }; };
    "Alt+grave"       = { next-window     = _: { props.filter = "app-id"; }; };
    "Alt+Shift+grave" = { previous-window = _: { props.filter = "app-id"; }; };
  };

  binds = {
    # --- Binds que reemplazan a los del default ---
    # Mod+D ahora abre el launcher de dms en vez de fuzzel
    "Mod+D" = { hotkey-overlay-title = "Application Launcher"; spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ]; };
    # Mod+M ahora es Task Manager (en default era maximize-window-to-edges)
    "Mod+M" = { hotkey-overlay-title = "Task Manager"; spawn = [ "dms" "ipc" "call" "processlist" "focusOrToggle" ]; };
    # Mod+V ahora es Clipboard (en default era toggle-window-floating)
    "Mod+V" = { hotkey-overlay-title = "Clipboard Manager"; spawn = [ "dms" "ipc" "call" "clipboard" "toggle" ]; };
    # Mod+Comma ahora es Settings (en default era consume-window-into-column)
    "Mod+Comma" = { hotkey-overlay-title = "Settings"; spawn = [ "dms" "ipc" "call" "settings" "focusOrToggle" ]; };
    # Mod+Ctrl+R ahora es reset-window-height con alias Mod+Alt+R
    "Mod+Alt+R".reset-window-height = _: {};
    # Mod+Shift+V reemplazado por Mod+Space
    "Mod+Space".switch-focus-between-floating-and-tiling = _: {};
    "Mod+Shift+Space".toggle-window-floating = _: {};
    # Ctrl+Left/Right ahora mueven monitor (no columna)
    "Mod+Ctrl+Left".focus-monitor-left   = _: {};
    "Mod+Ctrl+Right".focus-monitor-right = _: {};
    # Ctrl+J/K ahora mueven monitor (no ventana)
    "Mod+Ctrl+J".focus-monitor-down = _: {};
    "Mod+Ctrl+K".focus-monitor-up   = _: {};
    # Shift+H/J/K/L ahora mueven columna/ventana (no monitor)
    "Mod+Shift+H".move-column-left  = _: {};
    "Mod+Shift+J".move-window-down  = _: {};
    "Mod+Shift+K".move-window-up    = _: {};
    "Mod+Shift+L".move-column-right = _: {};
    # Shift+Left/Right/Down/Up
    "Mod+Shift+Left".move-column-left   = _: {};
    "Mod+Shift+Right".move-column-right = _: {};
    # Super+Shift+Down/Up mueven ventana
    "Super+Shift+Down".move-window-down = _: {};
    "Super+Shift+Up".move-window-up     = _: {};
    # Ctrl+I/U ahora mueven workspace (en default eran focus-workspace)
    "Mod+Ctrl+I".move-workspace-up   = _: {};
    "Mod+Ctrl+U".move-workspace-down = _: {};
    # Shift+I/U mueven columna a workspace (en default eran move-workspace)
    "Mod+Shift+I".move-column-to-workspace-up   = _: {};
    "Mod+Shift+U".move-column-to-workspace-down = _: {};
    # Shift+1-9 mueven columna a workspace
    "Mod+Shift+1".move-column-to-workspace = 1;
    "Mod+Shift+2".move-column-to-workspace = 2;
    "Mod+Shift+3".move-column-to-workspace = 3;
    "Mod+Shift+4".move-column-to-workspace = 4;
    "Mod+Shift+5".move-column-to-workspace = 5;
    "Mod+Shift+6".move-column-to-workspace = 6;
    "Mod+Shift+7".move-column-to-workspace = 7;
    "Mod+Shift+8".move-column-to-workspace = 8;
    "Mod+Shift+9".move-column-to-workspace = 9;
    # Super+Ctrl+Page_Down/Up mueven workspace
    "Super+Ctrl+Page_Down".move-workspace-down = _: {};
    "Super+Ctrl+Page_Up".move-workspace-up     = _: {};
    # Super+Shift+Page_Down/Up mueven columna a workspace
    "Super+Shift+Page_Down".move-column-to-workspace-down = _: {};
    "Super+Shift+Page_Up".move-column-to-workspace-up     = _: {};

    # Lock: Mod+Alt+L en vez de Super+Alt+L
    "Mod+Alt+L" = { hotkey-overlay-title = "Lock Screen"; spawn = [ "dms" "ipc" "call" "lock" "lock" ]; };

    # Terminal: kitty en vez de alacritty
    "Mod+Return" = { hotkey-overlay-title = "Open Terminal"; spawn = "kitty"; };

    # Quit: Ctrl+Alt+Delete ahora abre processlist en vez de quit
    "Ctrl+Alt+Delete" = { hotkey-overlay-title = "Task Manager"; spawn = [ "dms" "ipc" "call" "processlist" "focusOrToggle" ]; };

    # Super+Tab = toggle-overview
    "Super+Tab" = { repeat = false; toggle-overview = _: {}; };

    # --- Binds de audio/brillo vía dms (reemplazan los del default) ---
    "XF86AudioRaiseVolume"     = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "increment" "3" ]; };
    "XF86AudioLowerVolume"     = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "decrement" "3" ]; };
    "XF86AudioMute"            = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "mute" ]; };
    "XF86AudioMicMute"         = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "audio" "micmute" ]; };
    "XF86AudioPlay"            = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "playPause" ]; };
    "XF86AudioPause"           = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "playPause" ]; };
    "XF86AudioStop"            = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "next" ]; };
    "XF86AudioPrev"            = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "previous" ]; };
    "XF86AudioNext"            = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "next" ]; };
    "XF86MonBrightnessUp"      = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "brightness" "increment" "5" "" ]; };
    "XF86MonBrightnessDown"    = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "brightness" "decrement" "5" "" ]; };
    "Ctrl+XF86AudioRaiseVolume" = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "increment" "3" ]; };
    "Ctrl+XF86AudioLowerVolume" = { allow-when-locked = true; spawn = [ "dms" "ipc" "call" "mpris" "decrement" "3" ]; };

    # Screenshots adicionales con XF86Launch1
    "XF86Launch1".screenshot              = _: {};
    "Alt+XF86Launch1".screenshot-window   = _: {};
    "Ctrl+XF86Launch1".screenshot-screen  = _: {};

    # --- Binds completamente nuevos (no existen en default) ---
    "Ctrl+Shift+R"  = { hotkey-overlay-title = "Rename Workspace"; spawn = [ "dms" "ipc" "call" "workspace-rename" "open" ]; };
    "Mod+N"         = { hotkey-overlay-title = "Notification Center"; spawn = [ "dms" "ipc" "call" "notifications" "toggle" ]; };
    "Mod+Shift+N"   = { hotkey-overlay-title = "Notepad"; spawn = [ "dms" "ipc" "call" "notepad" "toggle" ]; };
    "Mod+Shift+W"   = { hotkey-overlay-title = "Create window rule"; spawn = [ "dms" "ipc" "call" "window-rules" "toggle" ]; };
    "Mod+Y"         = { hotkey-overlay-title = "Browse Wallpapers"; spawn = [ "dms" "ipc" "call" "dankdash" "wallpaper" ]; };
    "Super+X"       = { hotkey-overlay-title = "Power Menu: Toggle"; spawn = [ "dms" "ipc" "call" "powermenu" "toggle" ]; };
    "Super+B"       = { hotkey-overlay-title = "Abrir Firefox"; spawn = [ "flatpak" "run" "org.mozilla.firefox" ]; };
    "Super+E"       = { hotkey-overlay-title = "Abrir el Explorador de archivos (Nautilus)"; spawn = "nautilus"; };
    "Super+Shift+B" = { hotkey-overlay-title = "Abrir Zen Browser"; spawn = "zen"; };
  };
};
