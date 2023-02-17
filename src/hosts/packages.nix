{
  inputs,
  cell,
}:
let
  inherit (inputs) nixpkgs darwin;
in
  {
    darwinConfigurations."pro" = darwin.lib.darwinSystem {
    #default = darwin.lib.darwinSystem {
      # you can have multiple darwinConfigurations per flake, one per hostname
      system = "x86_64-darwin";
      modules = [ ./darwin/pro.nix ];
    };

    darwinConfigurations."pro-m2" = darwin.lib.darwinSystem {
    #default = darwin.lib.darwinSystem {
      # you can have multiple darwinConfigurations per flake, one per hostname
      system = "aarch64-darwin";
      modules = [ ./darwin/pro.nix ];
    };

}
