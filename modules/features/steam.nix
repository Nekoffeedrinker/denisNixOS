{self, ...}: {
  flake.nixosModules.steam = {pkgs, ...}: {
    imports = [self.nixosModules.graficos];

    # Arreglar la pantalla negra cuando se abre en Niri
    nixpkgs.overlays = [
      (final: prev: {
        steam = prev.steam.override {
          extraArgs = "-cef-disable-gpu-compositing";
        };
      })
    ];

    # Instalar steam
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true; # Por si hay problemas de escalado o resolución
    };
    programs.gamemode.enable = true; # Demonio para mejorar rendimiento

    environment.systemPackages = with pkgs; [
      mangohud # monitoreo de fps
      protonup-ng
    ];

    # ProtonUP
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    /*
    Para utilizar gamescope, gamemode y mangohud, se deben declarar en las
    opciones de lanzamiento generales o de un juego específico.
    */
  };
}
