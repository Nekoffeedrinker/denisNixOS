{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    niri-float-sticky.url = "github:probeldev/niri-float-sticky";

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Commit en el que funciona intel-compute-runtime-legacy para mi ThinkPad X13 gen 2.
    # Es un paquete gráfico de las GPU intel que es necesario para Davinci Resolve.
    nixpkgs-igc-fix.url = "github:nixos/nixpkgs/0c3fc1cd3494aa52a2c111d5f18a7689fd15ab83";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
