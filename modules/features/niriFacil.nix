{inputs, ...}: {
  flake.nixosModules.denisNiri = {pkgs, ...}: {
    # Instalar Niri
    programs.niri.enable = true;

    # activar portal (interfaz para que apps en
    # Wayland accedan a archivos, pantalla, etc.)
    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    environment.systemPackages = [
      pkgs.xwayland-satellite
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme
    ];

    programs.dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
    };
  };
}
