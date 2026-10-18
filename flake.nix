{
  description = "KTH DTEK";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in
    rec {
      # Declare packages
      legacyPackages = import ./default.nix { inherit pkgs; };
      packages.${system} = nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages;
    
      # Declare devshells
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          packages.${system}.dtekv-tools
        ];
      };
    };
}