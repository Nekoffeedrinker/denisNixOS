{...}: {
  flake.nixosModules.miniJuegos = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      gnome-mines
      gnome-chess
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
