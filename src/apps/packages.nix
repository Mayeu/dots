{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  myvim = nixpkgs.callPackage ./nvim.nix {};
}
