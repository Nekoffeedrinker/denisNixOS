{
  flake.nixosModules.virtManager = {
    pkgs,
    mainUser,
    ...
  }: {
    # Enable dconf (System Management Tool)
    programs.dconf.enable = true;

    # Add user to libvirtd group
    users.users.${mainUser}.extraGroups = ["libvirtd"];

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      virtio-win
      win-spice
    ];

    # Manage the virtualisation services
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          vhostUserPackages = with pkgs; [virtiofsd];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
