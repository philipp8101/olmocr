{ lib
, python3
, fetchPypi
, ... }:

python3.pkgs.buildPythonPackage rec {
  pname = "fuzzysearch";
  version = "0.7.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1aGxFM7uUKXhgbL+GsG0NxrI25IUJ3Ckj+1J7Lw3ykw=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  buildInputs = with python3.pkgs; [
    toolz
    attrs
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
