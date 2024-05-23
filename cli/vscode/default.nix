{
  config,
  foos,
  inputs,
  pkgs,
  ...
}:
let
  userDir =
    if pkgs.hostPlatform.isDarwin then
      "Library/Application Support/Code/User"
    else
      "${config.xdg.configHome}/Code/User";

  nixfmt = inputs.nixpkgs-nixfmt.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nixfmt-rfc-style;
in
{
  home.packages = [
    nixfmt
    pkgs.nil
  ];

  programs.vscode = {
    enable = true;
    extensions =
      let
        es = pkgs.vscode-extensions;
      in
      [
        es.eamodio.gitlens
        es.github.vscode-pull-request-github
        es.haskell.haskell
        es.jnoortheen.nix-ide
        es.mkhl.direnv
        es.ms-vscode-remote.remote-ssh
        es.rust-lang.rust-analyzer
        es.tamasfe.even-better-toml
        es.vscodevim.vim
      ];
    mutableExtensionsDir = false;
  };

  home.file."${userDir}/settings.json".source = foos pkgs ./settings.json;
}
