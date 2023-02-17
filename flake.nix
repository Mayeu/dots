{
  description = "My system configuration";

  inputs = {
      std.url = "github:divnix/std";
      #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
      nixpkgs.url = "github:NixOS/nixpkgs/master";
      #home-manager.url = "github:nix-community/home-manager";
      #home-manager.inputs.nixpkgs.follows = "nixpkgs";
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };

  outputs = { std, self, nixpkgs, home-manager, darwin }@inputs:
    std.growOn {
      inherit inputs;

      cellsFrom = ./src;

      cellBlocks = [
        (std.blockTypes.installables "packages" {ci.build = true;})
      ];

    }
    {
      packages = std.harvest self [ [ "hosts" "packages" ] ];
    };
}
