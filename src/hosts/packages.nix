{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs darwin m;
in {
  darwinConfigurations."pro-m2" = darwin.lib.darwinSystem {
    #default = darwin.lib.darwinSystem {
    # you can have multiple darwinConfigurations per flake, one per hostname
    specialArgs = {inherit m;};
    system = "aarch64-darwin";
    modules = [
      ./darwin/pro.nix
    ];
  };
}
