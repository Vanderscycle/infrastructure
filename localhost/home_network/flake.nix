{ 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux"; 
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # using application function
    packages.${system}.default = pkgs.poetry2nix.mkPoetryApplication {
      projectDir = self;
    };
    # nix eval .#foo
    foo = "bro";
  };
}