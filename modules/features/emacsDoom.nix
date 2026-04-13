{
  flake.nixosModules.paquetesDoomEmacs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      emacs

      # Requeridos
      ripgrep # regex pattern directory searcher
      fd # better `find`
      symbola # Fuente
      nerd-fonts.symbols-only
      shellcheck
      pandoc
    ];
  };
}
