{
  inputs,
  cell,
}:
/*
This file holds reproducible shells with commands in them.

They conveniently also generate config files in their startup hook.
*/
let
  inherit (cell) config;
  inherit (inputs) nixpkgs std;
  inherit (std) lib;
in {
  # Tool Homepage: https://numtide.github.io/devshell/
  default = inputs.std.lib.dev.mkShell {
    name = "My dots devshell";

    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      config.conform
      config.treefmt
      config.editorconfig
      config.githubsettings
      config.lefthook
      config.mdbook
    ];

    commands = [
      {
        category = "rendering";
        package = inputs.nixpkgs.mdbook;
      }
      {
        category = "dev-tools";
        package = inputs.std.packages.std;
      }
    ];
  };
}
