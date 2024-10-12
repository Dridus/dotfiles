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
        es.hashicorp.terraform
        es.haskell.haskell
        es.jnoortheen.nix-ide
        es.mechatroner.rainbow-csv
        es.mhutchie.git-graph
        es.mkhl.direnv
        es.ms-python.black-formatter
        es.ms-python.python
        es.ms-vscode.cpptools-extension-pack
        es.ms-vscode.makefile-tools
        es.ms-vscode.powershell
        es.ms-vscode-remote.remote-ssh
        es.rust-lang.rust-analyzer
        es.tamasfe.even-better-toml
        es.vscodevim.vim
        es.vue.volar
        es.zxh404.vscode-proto3
      ];
    mutableExtensionsDir = false;
  };

  home.file."${userDir}/settings.json".source = foos pkgs ./settings.json;
}
