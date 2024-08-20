{
  description = "Rust template using Naersk and Fenix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
    naersk.url = "github:nix-community/naersk";
  };

  outputs = { self, nixpkgs, fenix, naersk, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
        };

        toolchain = with fenix.packages.${system}; combine [
          minimal.cargo
          minimal.rustc
        ];

        naersk' = naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        };
      in rec {
        defaultPackage = packages.${system};

        packages.${system} = naersk'.buildPackage {
          src = ./.;
          strctDeps = true;
        };

        doCheck = true;

        # Devshell to run cargo builds
        devShells.default = pkgs.mkShell rec {
          # Include libraries in buildInputs
          buildInputs = with pkgs; [
            rust-analyzer
            toolchain
          ];

          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";

          shellHook = ''
            echo Rust!
          '';
        };
      });
}
