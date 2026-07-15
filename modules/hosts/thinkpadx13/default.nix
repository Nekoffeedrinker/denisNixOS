{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.thinkpadx13 = inputs.nixpkgs.lib.nixosSystem {
    # Valores reutilizables entre módulos
    specialArgs = {
      pkgs-unstable = import inputs.nixpkgs-inestable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      mainUser = "denis";
    };
    # Módulo principal
    modules = [
      self.nixosModules.thinkpadx13Configuration
    ];
  };
}
