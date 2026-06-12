{inputs, ...}: {
  flake.nixosModules.affinity = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.affinity-nix.overlays.default];
    environment.systemPackages = with pkgs; [
      affinity-v3
      # affinity-designer
      # affinity-photo
      # affinity-publisher
    ];
  };
}
