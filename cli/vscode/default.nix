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
    profiles.default.extensions =
      let
        es = pkgs.vscode-extensions;
        javascript-ejs-support = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "javascript-ejs-support";
            publisher = "digitalbrainstem";
            version = "1.3.3";
            hash = "sha256-VvZ1CzgAbdYj10/j5lE5s88Rq3puqmYDfu1IcvRXXWg=";
          };
          meta.license = pkgs.lib.licenses.mit;
        };
        openscad-language-support = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "openscad-language-support";
            publisher = "leathong";
            version = "2.0.1";
            hash = "sha256-GTvn97POOVmie7mOD/Q3ivEHXmqb+hvgiic9pTWYS0s=";
          };
        };
        remote-ssh = pkgs.callPackage ./remote-ssh.nix {};
      in
      [
        es.dbaeumer.vscode-eslint
        javascript-ejs-support
        es.eamodio.gitlens
        es.esbenp.prettier-vscode
        es.github.vscode-pull-request-github
        es.hashicorp.terraform
        es.haskell.haskell
        es.jnoortheen.nix-ide
        es.justusadam.language-haskell
        openscad-language-support
        es.mechatroner.rainbow-csv
        es.mkhl.direnv
        es.ms-python.black-formatter
        es.ms-python.python
        es.ms-toolsai.jupyter
        es.ms-vscode.cpptools-extension-pack
        es.ms-vscode.makefile-tools
        es.ms-vscode.powershell
        #es.ms-vscode-remote.remote-ssh
        remote-ssh
        es.nefrob.vscode-just-syntax
        es.rust-lang.rust-analyzer
        es.tamasfe.even-better-toml
        es.thenuprojectcontributors.vscode-nushell-lang
        es.vscodevim.vim
        es.vue.volar
        es.zxh404.vscode-proto3
      ];
    mutableExtensionsDir = false;
  };

  home.file = {
    "${userDir}/keybindings.json".source = foos pkgs ./keybindings.json;
    "${userDir}/settings.json".source = foos pkgs ./settings.json;
  };
}
