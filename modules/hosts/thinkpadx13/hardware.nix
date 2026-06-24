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
      device = "/dev/disk/by-uuid/ef67005d-ec38-45be-afc4-c7c5e5a1cdce";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/F716-54CC";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [
      {
        device = "/swapfile";
        size = 20480;
      }
    ];
    boot.resumeDevice = "/dev/nvme0n1p2";
    boot.kernelParams = ["resume_offset=133625856"];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
