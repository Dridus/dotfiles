{
  lib,
  buildGoModule,
  buildNpmPackage,
  fetchFromGitHub,
}:
let
  version = "0-unstable-2026-06-11";
  rev = "b1e44f9caf225c0d76a4cfc2c6a340990cb35e6f";

  src = fetchFromGitHub {
    owner = "kenn-io";
    repo = "agentsview";
    inherit rev;
    hash = "sha256-LfNFR9z1CHFHISCmW2C8UQAVRK/bPcX7aboS1XK+FTA=";
  };

  # The Svelte/Vite single-page app. The Go binary embeds the built assets
  # from internal/web/dist via go:embed, so we build the frontend first and
  # drop the result into that directory before compiling the backend.
  frontend = buildNpmPackage {
    pname = "agentsview-frontend";
    inherit version src;
    sourceRoot = "${src.name}/frontend";

    npmDepsHash = "sha256-0jkU6+i4g/0Dsa06deKkDcCyGcd9G9l2cDstG3tBMw0=";

    installPhase = ''
      runHook preInstall
      cp -r dist "$out"
      runHook postInstall
    '';
  };
in
buildGoModule {
  pname = "agentsview";
  inherit version src;

  vendorHash = "sha256-8f0f4/rqorR5ooF1+WbFCRNl1Ecq9aZoweDjPIq1XjA=";

  subPackages = [ "cmd/agentsview" ];

  # sqlite FTS5 (mattn/go-sqlite3) and the vendored duckdb static libraries
  # both require cgo.
  env.CGO_ENABLED = "1";
  tags = [ "fts5" ];

  # Embed the prebuilt frontend assets the Go binary expects at build time.
  preBuild = ''
    rm -rf internal/web/dist
    cp -r ${frontend} internal/web/dist
  '';

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=${rev}"
  ];

  # Backends spin up postgres/duckdb services; skip the heavy test suite.
  doCheck = false;

  meta = {
    description = "Local-first viewer for AI agent sessions";
    homepage = "https://github.com/kenn-io/agentsview";
    license = lib.licenses.mit;
    mainProgram = "agentsview";
    platforms = lib.platforms.unix;
  };
}
