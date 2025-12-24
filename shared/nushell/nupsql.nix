{
  lib,
  rustPlatform,
  fetchFromGitLab,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nu_plugin_nupsql";
  version = "9ecd2b82633fdbfc76b531623de6780e2d63665a";

  src = fetchFromGitLab {
    owner = "HertelP";
    repo = "nu_plugin_nupsql";
    rev = finalAttrs.version;
    hash = "sha256-VVikWS5SZJpu8Sb3kAWQ9tjU7xIVc30FrKuaB9jv8mM=";
  };

  cargoHash = "sha256-PTLV3rTASwfD0TmhOh1vizw9JJHNs7V2w+AxxZhkF0s=";

  # nativeBuildInputs = [ pkg-config ] ++ lib.optionals stdenv.cc.isClang [ rustPlatform.bindgenHook ];
  # buildInputs = [ openssl ];

  passthru.updateScript = nix-update-script {
    # Skip the version check and only check the hash because we inherit version from nushell.
    extraArgs = [ "--version=skip" ];
  };

  meta = {
    description = "A nushell plugin to query postgres databases.";
    mainProgram = "nu_plugin_nupsql";
    homepage = "https://gitlab.com/HertelP/nu_plugin_nupsql";
    license = lib.licenses.mit;
  };
})
