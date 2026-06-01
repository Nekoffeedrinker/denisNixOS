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

      # gramática mediante LangTool
      eloquent

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
    ];
    # Poder ejecutar los comandos doom
    environment.variables = {
      PATH = ["$HOME/.config/emacs/bin"];
    };
  };
}
