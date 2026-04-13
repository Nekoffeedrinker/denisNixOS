{
  # inputs,
  ...
}: {
  flake.nixosModules.denisNiri = {
    inputs,
    pkgs,
    ...
  }: {
    programs.niri.enable = true;
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
