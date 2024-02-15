{
  config,
  impurity,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) escapeShellArg mkOption types;
in {
  options = {
    dotfiles.homeFlake = mkOption {
      type = types.str;
      description = ''
        Path to the home flake.nix, since putting the home.nix in ~/.config/home-manager means that the flake must be at the top
        level, which is isn't for my dotfiles, and path: schemes don't support ?dir but the flakes don't only refer to things in
        the same folder.
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = config.programs.zsh.enable;
        message = "cli/misc expects zsh";
      }
    ];

    home = {
      homeDirectory = "/home/ross";

      packages = [
        pkgs.dnsutils
        pkgs.file
        pkgs.glibc.dev
        pkgs.gnumake
        pkgs.htop
        pkgs.linuxHeaders
        pkgs.openssh
        pkgs.openssl
        pkgs.openssl.dev
        pkgs.patchelf
        pkgs.pkg-config
        pkgs.pstree
        pkgs.rsync
        pkgs.screen
        pkgs.stdenv.cc
        pkgs.strace
        pkgs.unzip
        pkgs.xxd
        pkgs.zip
      ];

      sessionVariables.TERM = "xterm-256color";

      username = "ross";
    };

    nixpkgs.config = import ./nixpkgs-config.nix;
    xdg.configFile."nixpkgs/config.nix".source = impurity.link ./nixpkgs-config.nix;

    programs = {
      home-manager.enable = true;

      jq.enable = true;

      zsh.shellAliases = {
        hm = "env IMPURITY_PATH=\"${config.home.homeDirectory}/1st/dotfiles\" home-manager --impure --flake ${escapeShellArg config.dotfiles.homeFlake}";
        hmrepl = "env IMPURITY_PATH=\"${config.home.homeDirectory}/1st/dotfiles\" nix repl --impure ${escapeShellArg config.dotfiles.homeFlake}";
      };
    };
  };
}
