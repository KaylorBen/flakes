{
  description = "Nix flake templates and devshells";

  outputs = { self }: {

    templates = {
      rust = {
        path = ./rust;
        description = "Rust template using Naersk and Fenix";
      };

      latex = {
        path = ./tex;
        description = "Latex package builder, with continuos compile as well";
      };

      python = {
        path = ./pythonWithPkgs;
        description = "Python with other python packages";
      };

      clang = {
        path = ./clang;
        description = "C build and tools";
      };

      zig = {
        path = ./zig;
        description = "zig build and tools";
      };
    };
  };
}
