{inputs, ...}: {
  flake.nixosModules.denisNoctalia = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.kdeconnect.enable = true;
  };
}
