{...}: {
  flake.nixosModules.appImage = {pkgs, ...}: {
    # paquetes
    environment.systemPackages = with pkgs; [
      gearlever # administrador de AppImages
    ];

    # Soporte para AppImages
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
