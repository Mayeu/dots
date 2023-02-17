{
  description = "dots";

  inputs = {
      std.url = "github:divnix/std";
      #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
      nixpkgs.url = "github:NixOS/nixpkgs/master";
      #unstable.url = "github:NixOS/nixpkgs/master";
      #home-manager.url = "github:nix-community/home-manager";
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      #home-manager.inputs.nixpkgs.follows = "nixpkgs";
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };

  # add the inputs declared above to the argument attribute set
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
