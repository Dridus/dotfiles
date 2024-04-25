{
  foos,
  inputs,
  pkgs,
  ...
}: let
  bat-fzf-preview = pkgs.writeShellScriptBin "bat-fzf-preview" ''
    target_line="$1"
    first_window_line="$(($target_line-$FZF_PREVIEW_LINES/2))"
    last_window_line="$(($target_line+$FZF_PREVIEW_LINES))"
    shift
    ${pkgs.bat}/bin/bat \
      --color=always \
      --style=numbers \
      --highlight-line=$target_line \
      --line-range=$(($first_window_line<1?1:$first_window_line)):$(($last_window_line)) \
      "$@"
  '';
in {
  home = {
    packages = [
      bat-fzf-preview
      inputs.nixpkgs-nixfmt.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nixfmt-rfc-style
      pkgs.fd
      pkgs.fzf
      pkgs.neovim
      pkgs.nil
      pkgs.ripgrep
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FZF_DEFAULT_COMMAND = "fd --type f";
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      inherit (inputs.nil.packages.${pkgs.stdenv.hostPlatform.system}) nil;
    })
  ];

  xdg = {
    configFile.nvim.source = foos pkgs ./.;

    dataFile."nvim/site/autoload/plug.vim".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/junegunn/vim-plug/8fdabfba0b5a1b0616977a32d9e04b4b98a6016a/plug.vim";
      sha256 = "4tvXyNcyrnl+UFnA3B6WS5RSmjLQfQUdXQWHJ0YqQ/0=";
    };
  };
}
