{ lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep escapeShellArg;
in
{
  environment = {
    etc."resolv.conf".text = ''
      nameserver 1.1.1.1
    '';

    shellAliases.nixosrb = concatStringsSep " " [
      "${pkgs.nixos-rebuild}/bin/nixos-rebuild"
      "--impure"
      "--flake"
      (escapeShellArg "git+file:///home/ross/1st/dotfiles?dir=systems/lightbreaker")
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "lightbreaker";
    firewall.allowedTCPPorts = [
      3000
      8000
      8080
    ]; # vite
  };

  nix.settings = {
    extra-sandbox-paths = [
      "/var/nix-sandbox-shared"
    ];
    substituters = [
      "https://cache.nixos.org/"
      "https://hydra.vital.company/"
    ];
    trusted-users = [ "ross" ];
    experimental-features = [
      "nix-command"
      "flakes"
      "repl-flake"
    ];
    netrc-file = "/etc/netrc";
    max-jobs = 6;
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs = {
    zsh.enable = true;
  };

  security.sudo = {
    extraConfig = ''
      Defaults env_keep+=SSH_AUTH_SOCK
    '';
  };

  services = {
    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
    };

    openssh = {
      enable = true;
      settings.AcceptEnv = "LANG LC_TERMINAL";
    };

    postgresql = {
      enable = true;
      port = 5432;
      package = pkgs.postgresql;
    };

    tailscale.enable = true;
  };

  systemd.services.nix-daemon.environment.AWS_SHARED_CREDENTIALS_FILE = "/var/nix-sandbox-shared/aws_credentials";

  time.timeZone = "America/New_York";

  users.users.ross = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
