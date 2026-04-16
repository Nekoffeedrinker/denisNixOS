{inputs, ...}: {
  flake.nixosModules.denisNoctalia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      quickshell

      # Para Clipper
      cliphist
      wl-clipboard
    ];
    # Que funcione la huella
    security.pam.services.login.fprintAuth = true;

    programs.kdeconnect.enable = true;
  };
}
