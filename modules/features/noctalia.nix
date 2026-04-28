{
  # self, /* Solo si hay imports */
  inputs,
  ...
}: {
  flake.nixosModules.noctalia = {
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

    # para Slow Bongo
    users.users.${mainUser}.extraGroups = ["input"];
  };
}
