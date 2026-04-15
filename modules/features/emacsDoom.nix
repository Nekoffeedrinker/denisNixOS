{
  flake.nixosModules.paquetesDoomEmacs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      emacs

      # Requeridos
      git
      ripgrep # better `grep`
      fd # better `find`
      symbola # Fuente
      nerd-fonts.symbols-only
      shellcheck
      pandoc
    ];
    # Poder ejecutar los comandos doom
    environment.sessionVariables = {
      PATH = ["$HOME/.emacs.d/bin"];
    };
  };
}
