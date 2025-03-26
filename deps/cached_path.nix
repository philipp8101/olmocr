{ lib
, python3
, fetchPypi
, pkgs-stable }:

python3.pkgs.buildPythonPackage rec {
  pname = "cached_path";
  version = "1.7.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-IAkh+dRU/L27lkgDWmv5sUjoItu+/fU/mHYpcHau2d4=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  buildInputs = with python3.pkgs; [
    requests
    rich
    filelock
    boto3
    google-cloud-storage
    (huggingface-hub.overrideAttrs { inherit (pkgs-stable.python3.pkgs.huggingface-hub) version src; })
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
