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

    "${inputs.local}/config-local.nix"
    inputs.nixos-wsl.nixosModules.wsl
  ];

  environment = {
    etc."resolv.conf".text = ''
      nameserver 1.1.1.1
    '';

    shellAliases.nixosrb = "${pkgs.nixos-rebuild}/bin/nixos-rebuild --flake ${escapeShellArg "git+file:///home/ross/1st/dotfiles?dir=systems/monsoonite"}";

    systemPackages = with pkgs; [
      linuxPackages.usbip
      usbutils
    ];
  };

  networking = {
    hostName = "monsoonite";
    firewall.allowedTCPPorts = [3000]; # vite
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      substituters = ["https://cache.nixos.org/" "https://hydra.vital.company/"];
      trusted-users = ["ross"];
    };
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
      netrc-file = /etc/netrc
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

  services.tailscale.enable = true;

  system.stateVersion = "22.05";

  users.users.ross = {
    #extraGroups = [ "docker" ];
    shell = "/home/ross/.nix-profile/bin/zsh";
  };

  #virtualisation.docker.enable = true;
}
