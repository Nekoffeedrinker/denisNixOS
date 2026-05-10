{...}: {
  flake.nixosModules.distrobox = {pkgs, ...}: {
    # dependencias
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    # instalar distrobox
    environment.systemPackages = [pkgs.distrobox];
  };
}
