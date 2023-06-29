{ 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux"; 
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # using application function
    packages.${system}.default = pkgs.poetry2nix.mkPoetryApplication {
      projectDir = ./.;
    };
    # nix eval .#foo
    foo = "bro";
  };
}
# nix build (to build flakes) outputs will be 