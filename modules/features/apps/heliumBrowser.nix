{inputs, ...}: {
  flake.nixosModules.heliumBrowser = {...}: {
    imports = [
      inputs.helium-flake.nixosModules.default
    ];

    programs.helium = {
      enable = true;
      flags = ["--ozone-platform-hint=auto"];
      # policies = { ... };
    };
  };
}
