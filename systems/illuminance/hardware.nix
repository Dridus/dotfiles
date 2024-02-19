{
  config,
  lib,
  pkgs,
  ...
}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot.enable = true;
    };
    extraModulePackages = [];
    kernelModules = [];
    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci"];
      kernelModules = ["kvm-intel"];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/588fd11f-7ac3-4423-a854-0537a9380e4d";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/C7DF-0FE9";
      fsType = "vfat";
    };
  };

  hardware = {
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    nvidia = {
      # dynamicBoost.enable = true; # Ampere (RTX 30xx) or newer only
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = [pkgs.intel-media-driver pkgs.intel-vaapi-driver pkgs.nvidia-vaapi-driver];
      extraPackages32 = let p = pkgs.pkgsi686Linux; in [p.intel-media-driver p.intel-vaapi-driver p.nvidia-vaapi-driver];
    };
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services.xserver.videoDrivers = ["intel" "nvidia"];

  sound.enable = true;

  swapDevices = [
    {device = "/dev/disk/by-uuid/16af6e7c-de1e-4c6c-a86f-99e437c9c13c";}
  ];
}
