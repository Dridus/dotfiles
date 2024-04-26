{ lib, modulesPath, ... }:

{
  imports = [ "${modulesPath}/virtualisation/parallels-guest.nix" ];

  boot = {
    initrd = {
      availableKernelModules = [
        "virtio_pci"
        "xhci_pci"
        "usbhid"
        "usb_storage"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/617f3c26-b23d-4865-995b-ce7fc55ae627";
    fsType = "ext4";
  };

  # hardware.parallels.enable = true;

  swapDevices = [ { device = "/dev/disk/by-uuid/562a20d5-82f8-485c-8995-b5b4d55116cb"; } ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
