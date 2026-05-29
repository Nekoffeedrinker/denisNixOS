{inputs, ...}: {
  flake.nixosModules.flatpak = {...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      update = {
        onActivation = true;
        auto = {
          enable = true;
          onCalendar = "weekly";
        };
      };
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];
      packages = [
        {
          appId = "com.github.tchx84.Flatseal";
          origin = "flathub";
        }
      ];
    };
  };
}
