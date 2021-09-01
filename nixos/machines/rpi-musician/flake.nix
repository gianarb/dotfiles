{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {

    #defaultPackage.x86_64-linux = nixos-generators.nixosGenerate {
    #pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #modules = [
    #./configuration.nix
    #];
    #format = "iso";
    #};


    defaultPackage.aarch64-linux = nixos-generators.nixosGenerate {
      pkgs = nixpkgs.legacyPackages.aarch64-linux;
      modules = [
        ./configuration.nix
      ];
      format = "sd-aarch64";
    };
  };
}
