{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot.enable = true;
    };
    extraModulePackages = [ ];
    kernelModules = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" "sdhci_pci" ];
      kernelModules = [ ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7a5e0342-2df1-466f-8c63-66e5c5fecab5";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/6CA3-1B19";
      fsType = "vfat";
    };
  };

  hardware = {
    asahi = {
      # experimentalGPUInstallMode = "overlay";
      useExperimentalGPUDriver = true;
    };
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  sound.enable = true;

  swapDevices = [ ];
}
