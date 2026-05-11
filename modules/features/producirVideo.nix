{...}: {
  flake.nixosModules.prodVideo = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      obs-studio
    ];

    # Flatpak
    services.flatpak.packages = [
      {
        appId = "no.mifi.losslesscut";
        origin = "flathub";
      }
      {
        appId = "dk.nikse.subtitleedit";
        sha256 = "6d8e584074bf1aec68eedb65e3c119f3545f2daeb3105367fd5a5db7e694656b";
        bundle = "file:///home/denis/denisNixOS/modules/features/flatpak-bundle/SubtitleEdit-linux-x64.flatpak";
      }
    ];
  };
}
