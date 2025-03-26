{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  inputs.flake-utils.lib.eachDefaultSystem (system: let 
    pkgs = import nixpkgs {inherit system; allowUnfree = true;};
    pkgs-stable = import inputs.nixpkgs-stable {inherit system;};
    in {
      packages = rec {
        lingua = pkgs.callPackage ./deps/lingua_language_detector.nix {};
        deps = builtins.map (p: pkgs.callPackage p {inherit pkgs-stable;}) (import ./deps);
        olmocr = pkgs.python3.pkgs.buildPythonPackage {
          name = "olmocr";
          src = ./.;
          pyproject = true;
          build-system = with pkgs.python312Packages; [
            setuptools
          ];
          nativeBuildInputs = [ pkgs.python312Packages.boto3 ];
          buildInputs = with pkgs.python312Packages; [
            pypdf
            smart-open
            pypdf
            cryptography
            pillow
            ftfy
            bleach
            markdown2
            filelock
            orjson
            requests
            zstandard
            boto3
            httpx
            torch
            transformers
            rapidfuzz
            boto3
          ] ++ deps;
        };
        slang = pkgs.python3.pkgs.buildPythonPackage rec {
          pname = "sglang";
          version = "0.4.4.post1";
          pyproject = true;
          src = pkgs.fetchPypi {
            inherit pname version;
            hash = "sha256-eVbvfNA8PHAt+jtYkLuiG5htMikU1hXb+UB4Ygx+Zmg=";
          };
          build-system = [
            pkgs.python3.pkgs.setuptools
          ];
          doChecks = false;
          buildInputs = with pkgs.python3.pkgs; [
             aiohttp
             requests
             tqdm
             numpy
             ipython
             setproctitle
          ];
        };
      };
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
        # poppler-utils ttf-mscorefonts-installer msttcorefonts fonts-crosextra-caladea fonts-crosextra-carlito gsfonts lcdf-typetools
          poppler_utils
          caladea
          lcdf-typetools
          (pkgs.python3.withPackages (p: with p; [
            self.packages.${system}.olmocr
            self.packages.${system}.slang
            boto3
            httpx
            pypdf
            smart-open
            pypdf
            cryptography
            pillow
            ftfy
            bleach
            markdown2
            filelock
            orjson
            requests
            zstandard
            boto3
            httpx
            (torch.override { cudaSupport = true; })
            transformers
            rapidfuzz
            boto3
            google-cloud-core
            google-cloud-storage
          ] ++ self.packages.${system}.deps))
        ];
      };
    }
  );
}
