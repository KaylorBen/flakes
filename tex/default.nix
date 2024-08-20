{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.stdenv.mkDerivation {
  name = "pdf";
  src = ./.;
  buildInputs = with pkgs; [
    # Can be changed to specific tex packages needed
    texliveFull
  ];
  buildPhase = ''
    mkdir -p .cache/latex
    latexmk -interaction=nonstopmode -auxdir=.cache/latex -pdf template.tex
  '';
  installPhase = ''
    mkdir -p $out
    cp template.pdf $out
  '';
}
