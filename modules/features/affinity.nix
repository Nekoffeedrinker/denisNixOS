{inputs, ...}: {
  flake.nixosModules.affinity = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.affinity-nix.overlays.default];
    environment.systemPackages = [pkgs.affinity-v3];
  };
}
