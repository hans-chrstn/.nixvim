{
  description = "My NixVim Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nvf,
  }: let
    lib = nixpkgs.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = f: lib.genAttrs systems f;
    nvfFor = system: (nvf.lib.neovimConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [./src];
      }).neovim;
  in {
    packages = forAllSystems (system: {
      default = nvfFor system;
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${(nvfFor system)}/bin/nvim";
      };

      new-component = {
        type = "app";
        program = "${self}/scripts/new-component.sh";
      };
    });

    devShells = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            self.packages.${system}.default
            alejandra
            git
          ];
        };
      }
    );
  };
}
