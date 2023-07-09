{
  description = "Infrastructure pre-commit hooks";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, poetry2nix }:
    let
      application = { pkgs }:
        let
          inherit (poetry2nix.legacyPackages.${pkgs.system}) mkPoetryApplication;
        in mkPoetryApplication {
            projectDir = ./.;
            preferWheels = true;
        };

      dev-env = { pkgs }:
        let
          inherit (poetry2nix.legacyPackages.${pkgs.system}) mkPoetryPackages;
          pyEnv = mkPoetryPackages {
            projectDir = ./.;
            preferWheels = true;
            groups = [ "dev" ];
          };
        in pkgs.mkShell {
            name = "dev-shell";
            nativeBuildInputs = [
              poetry2nix.packages.${pkgs.system}.poetry
              pyEnv.poetryPackages
            ];
       };

      pkgs = (import nixpkgs {
        system = "x86_64-linux";
      });

    in {
      packages.x86_64-linux.default = application { inherit pkgs; };
      devShells.x86_64-linux.default = dev-env { inherit pkgs; };
    };
}