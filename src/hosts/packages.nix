{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs darwin m nix-rosetta-builder;
in {
  # A CI config to start the linux-builder
  darwinConfigurations."ci" = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      {system.stateVersion = 6;}
      ./modules/nix-macos.nix
    ];
  };

  darwinConfigurations."pro-m2" = darwin.lib.darwinSystem {
    #default = darwin.lib.darwinSystem {
    # you can have multiple darwinConfigurations per flake, one per hostname
    specialArgs = {inherit m;};
    system = "aarch64-darwin";
    modules = [
      ./modules/nix-macos.nix
      ./darwin/pro.nix
      nix-rosetta-builder.darwinModules.default
      {
        # see available options in module.nix's options.nix-rosetta-builder`
        nix-rosetta-builder = {
          enable = true;
          onDemand = true;
        };
      }
    ];
  };
}
