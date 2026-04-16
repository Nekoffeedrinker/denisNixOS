{...}: {
  flake.nixosModules.denisNiri = {pkgs, ...}: {
    # Instalar Niri
    programs.niri.enable = true;

    # activar portal (interfaz para que apps en
    # Wayland accedan a archivos, pantalla, etc.)
    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    security.polkit.enable = true;

    environment.systemPackages = [
      pkgs.xwayland-satellite
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme
    ];
  };
}
