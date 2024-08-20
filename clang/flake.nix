{
  description = "Nix flake for C / C++ projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
      in {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            gcc # for gcc
            # clang # for clang
            # clang-tools
            # clang-manpages
            gnumake
            # cmake # for cmake projects
            # meson # for projects using meson
            # ninja # for ninja build system
            # zig   # for using zig as a c/c++ compiler
          ];
        };
      }
    );
}
