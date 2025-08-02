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
        inherit (pkgs.vscode-extensions.dbaeumer) vscode-eslint;
        inherit (pkgs.vscode-extensions.denoland) vscode-deno;
        inherit (pkgs.vscode-extensions.eamodio) gitlens;
        inherit (pkgs.vscode-extensions.esbenp) prettier-vscode;
        inherit (pkgs.vscode-extensions.github) vscode-pull-request-github;
        inherit (pkgs.vscode-extensions.hashicorp) terraform;
        inherit (pkgs.vscode-extensions.haskell) haskell;
        inherit (pkgs.vscode-extensions.jnoortheen) nix-ide;
        inherit (pkgs.vscode-extensions.justusadam) language-haskell;
        inherit (pkgs.vscode-extensions.mechatroner) rainbow-csv;
        inherit (pkgs.vscode-extensions.mkhl) direnv;
        inherit (pkgs.vscode-extensions.ms-python) black-formatter;
        inherit (pkgs.vscode-extensions.ms-python) mypy-type-checker;
        inherit (pkgs.vscode-extensions.ms-python) python;
        inherit (pkgs.vscode-extensions.ms-toolsai) jupyter;
        inherit (pkgs.vscode-extensions.ms-vscode) cpptools-extension-pack;
        inherit (pkgs.vscode-extensions.ms-vscode) makefile-tools;
        inherit (pkgs.vscode-extensions.ms-vscode) powershell;
        inherit (pkgs.vscode-extensions.nefrob) vscode-just-syntax;
        inherit (pkgs.vscode-extensions.rust-lang) rust-analyzer;
        inherit (pkgs.vscode-extensions.svelte) svelte-vscode;
        inherit (pkgs.vscode-extensions.tamasfe) even-better-toml;
        inherit (pkgs.vscode-extensions.thenuprojectcontributors) vscode-nushell-lang;
        inherit (pkgs.vscode-extensions.vscodevim) vim;
        inherit (pkgs.vscode-extensions.vue) volar;
        inherit (pkgs.vscode-extensions.zxh404) vscode-proto3;

        claude-code = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "claude-code";
            publisher = "anthropic";
            version = "1.0.67";
            hash = "sha256-hS48yyFVAaNIOmFf9zARV+TDRv1QlfdMy9QJeWIcTsc=";
          };
        };

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

        remote-ssh = pkgs.callPackage ./remote-ssh.nix { };

        vscode-postgres = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "vscode-postgres";
            publisher = "ckolkman";
            version = "1.4.3";
            hash = "sha256-OCy2Nc35vmynoKxoUoTL2qyUoiByTMMPebEjySIZihQ=";
          };
        };
      in
      [
        black-formatter
        claude-code
        cpptools-extension-pack
        direnv
        even-better-toml
        gitlens
        haskell
        javascript-ejs-support
        jupyter
        language-haskell
        makefile-tools
        mypy-type-checker
        nix-ide
        openscad-language-support
        powershell
        prettier-vscode
        python
        rainbow-csv
        remote-ssh
        rust-analyzer
        svelte-vscode
        terraform
        vim
        volar
        vscode-deno
        vscode-eslint
        vscode-just-syntax
        vscode-nushell-lang
        vscode-postgres
        vscode-proto3
        vscode-pull-request-github
      ];
    mutableExtensionsDir = false;
  };

  home.file = {
    "${userDir}/keybindings.json".source = foos pkgs ./keybindings.json;
    "${userDir}/settings.json".source = foos pkgs ./settings.json;
  };
}
