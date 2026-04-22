{
  flake.nixosModules.thinkpadx13Hardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/a74e91d9-9413-4151-b7f6-59bdfa5149bd";
      fsType = "btrfs";
      options = ["subvol=@"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/a74e91d9-9413-4151-b7f6-59bdfa5149bd";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/CEF0-8FF4";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/92e72691-8922-4e61-8ded-9582dc8674b9";
      }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
