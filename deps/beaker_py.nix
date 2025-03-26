{ lib
, python3
, fetchPypi
, ... }:

python3.pkgs.buildPythonPackage rec {
  pname = "beaker_py";
  version = "1.34.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ebuTfUTjVFomkLObK8Pjb2msLx24sG8z+0iBSZf69UU=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  buildInputs = with python3.pkgs; [
    requests
    pydantic
    rich
    pyyaml
    docker
    toolz
  ];

  # has no tests
  doCheck = false;

  pythonImportsCheck = [
    "toolz.itertoolz"
    "toolz.functoolz"
    "toolz.dicttoolz"
  ];

  meta = {
    changelog = "https://github.com/pytoolz/toolz/releases/tag/${version}";
    homepage = "https://github.com/pytoolz/toolz";
    description = "List processing tools and functional utilities";
    license = lib.licenses.bsd3;
  };
}
