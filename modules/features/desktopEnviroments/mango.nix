{inputs, ...}: {
  flake.nixosModules.mango = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    programs.mango.enable = true;

    # activar portal (interfaz para que apps en
    # Wayland accedan a archivos, pantalla, etc.)
    # --------------------------------------------
    # xdg.portal.enable = true;
    # xdg.portal.extraPortals = with pkgs; [
    #   xdg-desktop-portal-gtk
    # ];
    # security.polkit.enable = true;

    # Overridear los portales que el módulo de mango jala automáticamente
    # para no entrar en conflicto con GNOME/niri
    xdg.portal.extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    xdg.portal.wlr.enable = lib.mkForce false;

    environment.systemPackages = [
      pkgs.xwayland-satellite
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme
    ];
  };
}
