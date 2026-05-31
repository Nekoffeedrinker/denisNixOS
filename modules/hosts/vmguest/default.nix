{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.vmguest = inputs.nixpkgs.lib.nixosSystem {
    # Valores reutilizables entre módulos
    specialArgs = {mainUser = "denis";};
    # Módulo principal
    modules = [
      self.nixosModules.vmguestConfiguration
    ];
  };
}
