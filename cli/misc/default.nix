{pkgs, ...}: {
  config = {
    home = {
      packages = [
        pkgs.acpi
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
    };

    nixpkgs.config = import ./nixpkgs-config.nix;
    programs.jq.enable = true;
    xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
  };
}
