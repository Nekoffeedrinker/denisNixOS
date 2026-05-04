{inputs, ...}: {
  flake.nixosModules.nixUtil = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      alejandra # code formatter
      nixd # lsp
      nh # nix helper
      nix-output-monitor # nix-binary bonito
      nvd # diferencias entre generaciones
    ];

    # Configuración de nixd
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
}
