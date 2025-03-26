{ lib
, python3
, fetchPypi
, ... }:

python3.pkgs.buildPythonPackage rec {
  pname = "sequence_align";
  version = "0.3.0";

  format = "wheel";
  src = fetchPypi {
    inherit pname version format;
    dist = "cp37";
    python = "cp37";
    abi = "abi3";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-Udb2BIXnUCH6lZyIM6XOloogD8xn4SGtFWzvZHXbdIs=";
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
