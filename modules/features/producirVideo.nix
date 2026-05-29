{self, ...}: {
  flake.nixosModules.prodVideo = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    # Paquetes
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      obs-studio
    ];

    # Flatpak
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        "no.mifi.losslesscut"
      ]
      ++ [
        rec {
          appId = "dk.nikse.subtitleedit";
          sha256 = "6d8e584074bf1aec68eedb65e3c119f3545f2daeb3105367fd5a5db7e694656b";
          bundle = "${pkgs.fetchurl {
            url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.0.0-beta24/SubtitleEdit-linux-x64.flatpak";
            inherit sha256;
          }}";
        }
      ];
  };
}
