{self, ...}: {
  flake.nixosModules.miniJuegos = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    # Paquetes
    environment.systemPackages = with pkgs; [
      gnome-mines
      gnome-chess
      stockfish # IA de ajedrez
      gnome-sudoku
      kdePackages.kpat
    ];

    # Flatpak
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        "de.til7701.Puzzled" # compilado de puzles
        "org.gnome.LightsOff"
        "io.github.basshift.Recall" # memoria
        "org.gnome.Quadrapassel" # Tetris
        "com.github.avojak.paint-spill" # conectar pintura
        "com.adilhanney.super_nonogram"
      ];
  };
}
