{
  description = "My system configuration";

  inputs = {
      std.url = "github:divnix/std";
      #nixpkgs.url = "nixpkgs/nixpkgs-22.11-darwin";
      nixpkgs.url = "nixpkgs/nixos-unstable";
      #home-manager.url = "github:nix-community/home-manager";
      #home-manager.inputs.nixpkgs.follows = "nixpkgs";
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...

      m.url = "gitlab:Mayeu/m";
      m.inputs.nixpkgs.follows = "nixpkgs";

      # TODO: help bring tezos via nix on macOS
      #tezos.url = "github:serokell/tezos-packaging";
  };

  outputs = { std, self, nixpkgs, home-manager, darwin, m }@inputs:
    std.growOn {
      inherit inputs;

      cellsFrom = ./src;

      cellBlocks = with std.blockTypes; [
        (installables "packages" {ci.build = true;})

        # presets
        (data "templates")
      ];

    }
    {
      devShells = std.harvest self ["repo" "shells"];
      packages = std.harvest self [["hosts" "packages"] ["apps" "packages"]];
      templates = std.pick inputs.self ["presets" "templates"];
    };
}
