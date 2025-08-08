{
  buildPythonApplication,
  fetchPypi,
  anthropic,
  click,
  dateparser,
  gitpython,
  jinja2,
  hatchling,
  mistune,
  packaging,
  pydantic,
  setuptools,
  textual,
  toml,
}:
buildPythonApplication rec {
  pname = "claude-code-log";
  version = "0.4.4";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "claude_code_log";
    hash = "sha256-A+CECPoc3Nyc4qSJ8oPVH8oIVPCk0nOWZO7O2Vjijlo=";
  };

  build-system = [
    setuptools
    hatchling
  ];

  dependencies = [
    anthropic
    click
    dateparser
    gitpython
    jinja2
    mistune
    packaging
    pydantic
    setuptools
    textual
    toml
  ];

  pythonRelaxDeps = [ "gitpython" ];
  pythonRemoveDeps = [ ];
  pythonImportsCheck = [ ];
}
