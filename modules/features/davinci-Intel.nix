{...}: {
  flake.nixosModules.davinciResolveIntel = {pkgs, ...}: {
    # instalar davinci
    environment.systemPackages = with pkgs; [
      davinci-resolve
    ];

    # Requerir gráficos
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime-legacy1 # Para Intel Gen 11 (tu i5-1135G7)
      ];
    };
  };
}
