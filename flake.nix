{
  description = "dots";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
      unstable.url = "github:NixOS/nixpkgs/master";
      #home-manager.url = "github:nix-community/home-manager";
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      #home-manager.inputs.nixpkgs.follows = "nixpkgs";
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };

  # add the inputs declared above to the argument attribute set
  outputs = { self, nixpkgs, unstable, home-manager, darwin }: {
    darwinConfigurations."Pro" = darwin.lib.darwinSystem {
      # you can have multiple darwinConfigurations per flake, one per hostname
      #system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
      system = "x86_64-darwin";
      # How to pass unstable to my module ?
      #inputs = { inherit unstable; };
      modules = [ ./nixpkgs.symlink/darwin-configuration.nix ]; # will be important later
  };
  };
}
