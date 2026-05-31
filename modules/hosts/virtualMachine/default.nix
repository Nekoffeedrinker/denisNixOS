{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.virtualMachine = inputs.nixpkgs.lib.nixosSystem {
    # Valores reutilizables entre módulos
    specialArgs = {mainUser = "denis";};
    # Módulo principal
    modules = [
      self.nixosModules.virtualMachine-Configuration
    ];
  };
}
