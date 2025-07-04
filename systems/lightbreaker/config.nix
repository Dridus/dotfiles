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
    enableIPv6 = false;
    firewall.enable = false; # VM
    hostName = "lightbreaker";
  };

  nix.settings = {
    cores = 5;
    extra-sandbox-paths = [ "/var/nix-sandbox-shared" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://hydra.vital.company/"
    ];
    trusted-users = [ "ross" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    netrc-file = "/etc/netrc";
    max-jobs = 2;
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
      package = pkgs.postgresql;
      settings.port = 5432;
    };

    tailscale.enable = true;

    udev.packages = [
      (pkgs.writeTextFile {
        name = "probe-rs";
        text = ''
          # Copy this file to /etc/udev/rules.d/
          # If rules fail to reload automatically, you can refresh udev rules
          # with the command "udevadm control --reload"

          # These rules are based on the udev rules from the OpenOCD project, with unsupported probes removed.
          # See http://openocd.org/ for more details.
          #
          # This file is available under the GNU General Public License v2.0 

          ACTION!="add|change", GOTO="probe_rs_rules_end"

          SUBSYSTEM=="gpio", MODE="0660", GROUP="plugdev", TAG+="uaccess"

          SUBSYSTEM!="usb|tty|hidraw", GOTO="probe_rs_rules_end"

          # Please keep this list sorted by VID:PID

          # STMicroelectronics ST-LINK V1
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="660", GROUP="plugdev", TAG+="uaccess"

          # STMicroelectronics ST-LINK/V2
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="660", GROUP="plugdev", TAG+="uaccess"

          # STMicroelectronics ST-LINK/V2.1
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="660", GROUP="plugdev", TAG+="uaccess"

          # STMicroelectronics STLINK-V3
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", MODE="660", GROUP="plugdev", TAG+="uaccess"

          # SEGGER J-Link
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0108", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1020", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="660", GROUP="plugdev", TAG+="uaccess"
          ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="660", GROUP="plugdev", TAG+="uaccess"


          # CMSIS-DAP compatible adapters
          ATTRS{product}=="*CMSIS-DAP*", MODE="660", GROUP="plugdev", TAG+="uaccess"

          LABEL="probe_rs_rules_end"

        '';
        destination = "/etc/udev/rules.d/69-probe-rs.rules";
      })
    ];
  };

  systemd.services.nix-daemon.environment.AWS_SHARED_CREDENTIALS_FILE = "/var/nix-sandbox-shared/aws_credentials";

  time.timeZone = "America/New_York";

  users = {
    groups.plugdev.gid = 10000;
    users.ross = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "plugdev"
        "dialout"
      ];
      shell = pkgs.zsh;
    };
  };
}
