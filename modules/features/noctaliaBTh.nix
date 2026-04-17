{...}: {
  flake.nixosModules.denisNoctaliaBTh = {
    pkgs,
    mainUser,
    ...
  }: {
    # Para el plugin Battery Threshold
    users.groups.battery_ctl = {};
    users.users.${mainUser}.extraGroups = ["battery_ctl"];
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="BAT*", \
          RUN+="${pkgs.coreutils}/bin/chgrp battery_ctl /sys$devpath/charge_control_end_threshold", \
          RUN+="${pkgs.coreutils}/bin/chmod g+w /sys$devpath/charge_control_end_threshold"
    '';
    services.udev.path = [pkgs.coreutils];
  };
}
