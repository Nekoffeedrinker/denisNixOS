{
  # self,
  inputs,
  ...
}: {
  #   flake.nixosModules.niri = {
  #     pkgs,
  # #    lib,
  #     ...
  #   }: {
  #     programs.niri = {
  #       enable = true;
  #       package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
  #     };
  #   };

  perSystem = {
    pkgs,
    lib,
    # self',
    ...
  }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        # spawn-at-startup = [
        #   (lib.getExe self'.packages.myNoctalia)
        # ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          keyboard.xkb = {
            layout = "us";
            variant = "altgr-intl";
            options = "caps:escape_shifted_capslock";
          };
          touchpad = {
            tap = _: {};
            natural-scroll = _: {};
            accel-profile = "flat";
          };
          mouse = {
            accel-speed = -0.7;
            accel-profile = "flat";
          };
          trackpoint = {
            accel-profile = "flat";
          };
        };

        outputs."eDP-1" = {
          position = _: {
            props = {
              x = 1920;
              y = 1200;
            };
          };
          background-color = "#000415";
        };

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = _: {};
          # "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };

        layout.gaps = 5;
      };
    };
  };
}
