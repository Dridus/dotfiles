{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

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

  hardware.parallels = {
    enable = true;
    package = config.boot.kernelPackages.prl-tools.overrideAttrs (
      final: prev: {
        postInstall = ''
          ${pkgs.bbe}/bin/bbe -e "s:/sbin/modprobe prl_tg\x00:modprobe prl_tg\x00\x00\x00\x00\x00\x00\x00:" -o $out/bin/.prltoolsd-wrapped.tmp $out/bin/.prltoolsd-wrapped
          mv $out/bin/.prltoolsd-wrapped{.tmp,}
          chmod 755 $out/bin/.prltoolsd-wrapped
          sed -i -e '/^exec/ i export PATH=$PATH:${pkgs.kmod}/bin' $out/bin/prltoolsd
        '';
      }
    );
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/562a20d5-82f8-485c-8995-b5b4d55116cb"; } ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
