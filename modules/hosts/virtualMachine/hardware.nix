{
  flake.nixosModules.virtualMachine-Hardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a1b0e12d-fc4a-463a-813d-d201b347b303";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/1e797e68-0225-4ebb-bce3-8c36383feee8"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
