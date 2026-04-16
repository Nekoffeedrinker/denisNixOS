{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.denisNoctalia = {
    pkgs,
    mainUser,
    ...
  }: {
    imports = [self.nixosModules.polkitGnome];

    # Que funcione la huella
    security.pam.services.noctalia = {
      fprintAuth = true;
      unixAuth = true;
    };
    environment.variables.NOCTALIA_PAM_SERVICE = "noctalia";

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      quickshell

      wtype # para launcher clipboard
      evtest # para Slow Bongo
    ];
    programs.kdeconnect.enable = true;

    users.users.${mainUser}.extraGroups = ["input"]; # para Slow Bongo
  };
}
