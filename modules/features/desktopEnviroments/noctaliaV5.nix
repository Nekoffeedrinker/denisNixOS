{inputs, ...}: {
  flake.nixosModules.noctaliaV5 = {pkgs-unstable, ...}: {
    imports = [
      inputs.noctalia.nixosModules.default
    ];

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
