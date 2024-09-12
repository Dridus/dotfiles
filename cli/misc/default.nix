{ pkgs, ... }:
{
  config = {
    home = {
      packages =
        [
          pkgs.btop
          pkgs.dnsutils
          pkgs.file
          pkgs.gnumake
          pkgs.openssh
          pkgs.openssl
          pkgs.pkg-config
          pkgs.pstree
          pkgs.rsync
          pkgs.screen
          pkgs.stdenv.cc
          pkgs.sqlite # cargo-docset wants libsqlite3
          pkgs.sqlite.dev # cargo-docset wants libsqlite3
          pkgs.unzip
          pkgs.xxd
          pkgs.zip
        ]
        ++ pkgs.lib.optionals pkgs.hostPlatform.isLinux [
          pkgs.acpi
          pkgs.glibc.dev
          pkgs.linuxHeaders
          pkgs.openssl.dev
          pkgs.patchelf
          pkgs.strace
        ];

      sessionVariables.TERM = "xterm-256color";
    };

    nixpkgs.config = import ./nixpkgs-config.nix;
    programs.jq.enable = true;
    xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
  };
}
