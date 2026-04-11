{ self, inputs, ... }: {

  flake.nixosConfigurations.thinkpadx13 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkpadx13Configuration
    ];
  };

}
