{inputs, ...}: {
  flake.nixosModules.denisNoctalia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      quickshell

      wtype # para launcher clipboard
      evtest # para Slow Bongo
    ];
    # Que funcione la huella
    security.pam.services.noctalia = {
      fprintAuth = true;
      unixAuth = true;
    };
    environment.variables.NOCTALIA_PAM_SERVICE = "noctalia";

    programs.kdeconnect.enable = true;

    users.users.mainUser.extraGroups = ["input"]; # para Slow Bongo
  };
}
