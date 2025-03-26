{ lib
, python3
, fetchPypi
, git
, ... }:

python3.pkgs.buildPythonPackage rec {
  pname = "pypdfium2";
  version = "4.30.1";
  
  format = "wheel";
  src = fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-9FQDKgvHaBkAFw9n2HEbOUKCRTHnZfkcL1znk3+Zl5Q=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  buildInputs = with python3.pkgs; [
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
