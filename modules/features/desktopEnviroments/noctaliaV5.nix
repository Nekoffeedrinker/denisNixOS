{inputs, ...}: {
  flake.nixosModules.noctaliaV5 = {pkgs-unstable, ...}: {
    imports = [
      inputs.noctalia.nixosModules.default
    ];

    # Usar la caché del binario en lugar de compiar en local
    nix.settings = {
      extra-substituters = ["https://noctalia.cachix.org"];
      extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    };

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    environment.systemPackages = with pkgs-unstable; [
      satty
    ];
    programs.kdeconnect.enable = true;
  };
}
