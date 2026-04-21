{
  flake.nixosModules.paquetesDoomEmacs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      emacs
      # == Requeridos ==
      # Doom
      git
      ripgrep # better `grep`
      fd # better `find`
      symbola # Fuente
      nerd-fonts.symbols-only
      shellcheck
      pandoc
      # vterm
      cmake
      gnumake
      # autoformater
      shfmt
      # visor PDF
      emacsPackages.pdf-tools
      # Typst
      typst
      tinymist
    ];
    # Poder ejecutar los comandos doom
    environment.sessionVariables = {
      PATH = ["$HOME/.emacs.d/bin"];
    };
  };
}
