{
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}: let
  inherit (lib) escapeShellArg;
in {
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    inputs.nixos-wsl.nixosModules.wsl
  ];

  environment = {
    etc."resolv.conf".text = ''
      nameserver 1.1.1.1
    '';

    shellAliases.nixosrb = "${pkgs.nixos-rebuild}/bin/nixos-rebuild --flake ${escapeShellArg "git+file:///home/ross/1st/dotfiles?dir=systems/lumen"}";

    systemPackages = with pkgs; [
      linuxPackages.usbip
      usbutils
    ];
  };

  networking = {
    hostName = "lumen";
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      trusted-users = ["ross"];
    };
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  wsl = {
    defaultUser = "ross";
    enable = true;
    interop.includePath = false;
    nativeSystemd = true;
    startMenuLaunchers = true;

    wslConf = {
      automount.root = "/mnt";
      network = {
        generateHosts = false;
        generateResolvConf = true;
      };
    };
  };

  system.stateVersion = "22.05";

  users.users.ross = {
    extraGroups = [];
    shell = "/home/ross/.nix-profile/bin/zsh";
  };
}
