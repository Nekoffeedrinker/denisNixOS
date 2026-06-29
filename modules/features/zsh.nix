{...}: {
  flake.nixosModules.zsh = {pkgs, ...}: {
    # Habilitar Zsh
    programs.zsh.enable = true;

    # Dependencias
    environment.systemPackages = with pkgs; [
      zoxide # para usarlo en zsh
      fzf # para usar fzf-tab en zsh
      bat # cat mejorado
      eza # ls mejorado
      lazygit
      (yazi.override {
        _7zz = _7zz-rar;
      })
    ];
  };
}
