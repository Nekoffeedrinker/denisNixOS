{self, ...}: {
  flake.nixosModules.steam = {pkgs, ...}: {
    imports = [self.nixosModules.graficos];
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud # monitoreo de fps
      protonup-ng
    ];

    # ProtonUP
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
