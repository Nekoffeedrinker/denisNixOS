{inputs, ...}: {
  flake.nixosModules.denisNoctalia = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.quickshell
    ];

    programs.kdeconnect.enable = true;
  };
}
