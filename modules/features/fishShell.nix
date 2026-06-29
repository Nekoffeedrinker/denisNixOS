{...}: {
  flake.nixosModules.fishShell = {pkgs, ...}: {
    # Habilitar Fish Shell
    programs.fish.enable = true;

    # Dependencias
    environment.systemPackages = with pkgs; [
      # -- de la config --
      starship

      # -- de los alias --
      bat # cat mejorado
      eza # ls mejorado
      lazygit
      (yazi.override {
        _7zz = _7zz-rar;
      })
    ];
  };
}
