{...}: {
  flake.nixosModules.minecraft = {pkgs, ...}: {
    # Instalar Prism Launcher
    environment.systemPackages = with pkgs; [prismlauncher];
  };
}
