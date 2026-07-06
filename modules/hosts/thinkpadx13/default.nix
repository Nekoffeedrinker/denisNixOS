{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.thinkpadx13 = inputs.nixpkgs.lib.nixosSystem {
    # Valores reutilizables entre módulos
    specialArgs = {
      pkgs-stable = import inputs.nixpkgs-estable {
        system = "x86_64-linux";
      };
      mainUser = "denis";
    };
    # Módulo principal
    modules = [
      self.nixosModules.thinkpadx13Configuration
    ];
  };
}
