{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # Example of how to pin a nixpkgs commits
    #nixpkgs.url = "github:nixos/nixpkgs/3005f20ce0aaa58169cdee57c8aa12e5f1b6e1b3";

    std.url = "github:divnix/std/369b8dc5b91becc372210ddcd73de84a294d1ee3";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.devshell.url = "github:numtide/devshell";
    std.inputs.nixago.url = "github:nix-community/nixago";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    m.url = "gitlab:Mayeu/m";
    m.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: help bring tezos via nix on macOS
    #tezos.url = "github:serokell/tezos-packaging";
  };

  outputs = {
    std,
    self,
    nixpkgs,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;

      cellsFrom = ./src;

      cellBlocks = with std.blockTypes; [
        (installables "packages" {ci.build = true;})
        (devshells "shells" {ci.build = true;})
        (nixago "config")
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
