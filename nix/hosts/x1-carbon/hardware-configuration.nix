# Do not modify this file directly. Regenerate it with nixos-generate-config
# on x1-carbon when its hardware or filesystems change.
{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7a186b61-6e8f-4e60-9a3c-0b1e2e059ad9";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/c0df8342-fc28-4af6-b732-80c802d04ebc"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
