{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {mainUser = "pilar";};
    modules = [
      self.nixosModules.wslConfiguration
    ];
  };
}
