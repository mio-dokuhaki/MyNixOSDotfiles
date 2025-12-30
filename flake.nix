{
  description = "MyNixOSDotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.mio-dokuhaki =
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/mio-dokuhaki/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mio-dokuhaki =
                import ./home/mio-dokuhaki/home.nix;
            }
          ];
        };
    };
}

