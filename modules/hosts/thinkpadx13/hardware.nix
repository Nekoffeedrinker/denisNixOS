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
      device = "/dev/disk/by-uuid/40a8a1b7-5b7d-4146-8d66-063c0d3270bf";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/11C8-1714";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    fileSystems."/mnt/Archivos" = {
      device = "/dev/disk/by-uuid/ec46e7cc-12e7-4e3e-b0f5-fa2876ba2717";
      fsType = "ext4";
      options = ["defaults" "noatime" "nofail" "x-gvfs-show"];
    };

    swapDevices = [
      {
        device = "/swapfile";
        size = 20480;
      }
    ];
    boot.resumeDevice = "/dev/nvme0n1p4";
    boot.kernelParams = ["resume_offset=170840064"];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
