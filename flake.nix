{
  description = "My NixVim Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixvim
  } @ inputs: let
    lib = nixpkgs.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = f: lib.genAttrs systems f;
    nixvimFor = system:
      nixvim.legacyPackages.${system}.makeNixvimWithModule {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        module = import ./src;
      };
  in
  {
    packages = forAllSystems (system: {
      default = nixvimFor system;
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${(nixvimFor system)}/bin/nvim";
      };

      new-plugin = {
        type = "app";
        program = "${self}/scripts/new-plugin.sh";
      };
    });

    devShells = forAllSystems (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = [ self.packages.${system}.default ];
      };
    });
  };
}
