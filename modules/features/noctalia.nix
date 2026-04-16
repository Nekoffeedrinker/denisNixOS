{inputs, ...}: {
  flake.nixosModules.denisNoctalia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      quickshell

      # Para Clipper
      cliphist
      wl-clipboard
    ];

    programs.kdeconnect.enable = true;
  };
}
