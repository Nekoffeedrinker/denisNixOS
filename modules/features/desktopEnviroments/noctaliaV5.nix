{inputs, ...}: {
  flake.nixosModules.noctaliaV5 = {...}: {
    imports = [
      inputs.noctalia.nixosModules.default
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    programs.kdeconnect.enable = true;
  };
}
