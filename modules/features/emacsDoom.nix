{
  flake.nixosModules.doomEmacs = {pkgs, ...}: {
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

      # ispell
      hunspell
      hunspellDicts.es-mx
      hunspellDicts.en-us

      # autoformater
      shfmt

      # dirvish
      vips # vistra previa de imágenes
      poppler-utils # vista previa de PDF

      # vterm
      cmake
      gnumake
      libtool

      # Compilar tree-sitter
      gcc

      # Typst
      typst
      tinymist # LSP
    ];
    # Poder ejecutar los comandos doom
    environment.sessionVariables = {
      PATH = ["$HOME/.emacs.d/bin"];
    };
  };
}
