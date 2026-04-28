{
  flake.nixosModules.graficos = {...}: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
