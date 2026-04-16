{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.thinkpadx13 = inputs.nixpkgs.lib.nixosSystem {
    # Valores reutilizables entre módulos
    specialArgs = {mainUser = "denis";};
    # Módulo principal
    modules = [
      self.nixosModules.thinkpadx13Configuration
    ];
  };
}
