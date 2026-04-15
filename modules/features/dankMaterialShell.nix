{inputs, ...}: {
  flake.nixosModules.denisDMS = {pkgs, ...}: {
    imports = [inputs.dms-plugin-registry.modules.default];

    programs.dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = false; # VPN management widget
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
      plugins = {
        # Añade los plugins por su ID (desde el registro)
        # https://github.com/AvengeMedia/dms-plugin-registry
        dankBatteryAlerts.enable = true;
        dankPomodoroTimer.enable = true;
        dankKDEConnect.enable = true;
        catWidget.enable = true;
        powerUsagePlugin.enable = true;
        developerUtilities.enable = true;
        tailscale.enable = true;
        airQuality.enable = true;

        # = launcher =
        calculator.enable = true;
        commandRunner.enable = true;
        emojiLauncher.enable = true;
        webSearch.enable = true;
        dankObsidian.enable = true;
        # dankBitwarden.enable = true;  # https://github.com/pacman99/DankBitwarden

        # = widgets =
        keybindingCheatSheet.enable = true; # https://github.com/stvnwrgs/dms-keybindings-cheat-sheet
        dankAudioVisualizer.enable = true;
        cavaVisualizer.enable = true;
        # desktopCommand.enable = true;  # https://github.com/yayuuu/desktopCommand

        # = Checar =
        simpleAudioControl.enable = true;
        # easyEffects.enable = true; # https://github.com/jonkristian/dms-easyeffects
        # displayMirror.enable = true;  # https://github.com/jfchenier/dms-display-mirror
        # displayManager.enable = true;  # https://github.com/felri/display-manager-plugin-niri-dank-linux
      };
    };
    programs.kdeconnect.enable = true;
  };
}
