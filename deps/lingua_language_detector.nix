{ lib
, python3
, fetchPypi
, ... }:

python3.pkgs.buildPythonPackage rec {
  pname = "lingua_language_detector";
  version = "2.1.0";

  format = "wheel";
  src = fetchPypi {
    inherit pname version format;
    dist = "cp312";
    python = "cp312";
    abi = "cp312";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    hash = "sha256-+DJYNNCdcAfmof+y/dGQekJmAdPSD3oJZZ7NYSyBy20=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  buildInputs = with python3.pkgs; [
    toolz
    pypdf
    (callPackage ./pypdfium2.nix {})
    (callPackage ./fuzzysearch.nix {})
    (callPackage ./sequence_align.nix {})
    (callPackage ./beaker_py.nix {})
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
