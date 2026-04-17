{
  # self, /* Solo si hay imports */
  inputs,
  ...
}: {
  flake.nixosModules.denisNoctalia = {
    pkgs,
    mainUser,
    ...
  }: {
    # == Que funcione la huella ==
    # imports = [self.nixosModules.polkitGnome]; /* replazado por plugin */
    security.pam.services.noctalia = {
      fprintAuth = true;
      unixAuth = true;
    };
    environment.variables.NOCTALIA_PAM_SERVICE = "noctalia";

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      quickshell

      wtype # para launcher clipboard
      evtest # para Slow Bongo (plugin)
    ];
    programs.kdeconnect.enable = true;

    # Para Battery Threshold (plugin)
    users.groups.battery_ctl = {};
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="BAT*", \
          RUN+="${pkgs.coreutils}/bin/chgrp battery_ctl /sys$devpath/charge_control_end_threshold", \
          RUN+="${pkgs.coreutils}/bin/chmod g+w /sys$devpath/charge_control_end_threshold"
    '';
    services.udev.path = [pkgs.coreutils];

    users.users.${mainUser}.extraGroups = [
      "battery_ctl" # battery threshold
      "input" # slow bongo
    ];
  };
}
