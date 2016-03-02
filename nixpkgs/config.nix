{
  allowUnfree = true;

  #vim.python=true;

  packageOverrides = pkgs : with pkgs; rec {
    my_neovim = import vim/customization.nix {inherit pkgs;};
  };
}
