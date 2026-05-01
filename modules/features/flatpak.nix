{inputs, ...}: {
  flake.nixosModules.flatpak = {...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages =
        map (id: {
          appId = id;
          origin = "flathub";
        }) [
          "com.github.tchx84.Flatseal"
          "com.parsecgaming.parsec"
        ];
    };
  };
}
