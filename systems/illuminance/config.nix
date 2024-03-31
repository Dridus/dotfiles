{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) concatStringsSep escapeShellArg;
in {
  environment = {
    shellAliases.nixosrb = concatStringsSep " " [
      "${pkgs.nixos-rebuild}/bin/nixos-rebuild"
      "--impure"
      "--flake"
      (escapeShellArg "git+file:///home/ross/1st/dotfiles?dir=systems/illuminance")
    ];

    systemPackages = [
      pkgs.intel-gpu-tools
      pkgs.libva-utils
      pkgs.nvtop
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "illuminance";
    networkmanager.enable = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes" "repl-flake"];
    max-jobs = 6;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["ross"];
    };
    dconf.enable = true;
    zsh.enable = true;
  };

  security = {
    pam.services.swaylock = {};
    polkit.enable = true;
    rtkit.enable = true; # needed for pipewire
  };

  services = {
    accounts-daemon.enable = true;

    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
    };

    hardware.bolt.enable = true;

    openssh.enable = true;

    pipewire = {
      enable = true;
      extraLv2Packages = [pkgs.lsp-plugins pkgs.bankstown-lv2];
      alsa.enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraLv2Packages = [pkgs.lsp-plugins pkgs.bankstown-lv2];
      };
    };

    xserver = {
      autorun = false;
      enable = true;
    };
    #   desktopManager.gnome.enable = true;
    #   displayManager = {
    #     defaultSession = "gnome";
    #     gdm.enable = true;
    #   };
    # };
  };

  time.timeZone = "America/New_York";

  users = {
    mutableUsers = false;
    users = {
      ross = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        shell = pkgs.zsh;
      };
    };
  };

  xdg.icons.enable = true;
  xdg.mime.enable = true;
}
