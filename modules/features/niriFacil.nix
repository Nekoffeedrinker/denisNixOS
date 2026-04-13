{inputs, ...}: {
  flake.nixosModules.denisNiri = {pkgs, ...}: {
    programs.niri.enable = true;
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme
    ];
	# activar portal (interfaz para que apps en 
	# Wayland accedan a archivos, pantalla, etc.)
    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
