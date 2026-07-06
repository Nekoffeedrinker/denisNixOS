{inputs, ...}: {
  flake.nixosModules.davinciResolveIntel = {...}: let
    pkgs-igc-fix = import inputs.nixpkgs-igc-fix {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    pkgs-davinci-pin = import inputs.nixpkgs-davinci2033 {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    # instalar davinci
    environment.systemPackages = [
      pkgs-davinci-pin.davinci-resolve
    ];

    # Requerir gráficos
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        pkgs-igc-fix.intel-compute-runtime-legacy1
        # Para Intel Gen 11 (El i5-1135G7 de la ThinkPad X13 Gen 2)
        # pineado a un commit específico para que funcione
      ];
    };
  };
}
