{
  allowUnfree = true;
  allowBroken = true;
  #build-use-chroot = true;

  #vim.python=true;

  packageOverrides = pkgs : with pkgs; rec {
    my_neovim = import vim/customization.nix {inherit pkgs;};
    corebird = import ./corebird.nix {inherit pkgs; inherit stdenv;};
  };
}
