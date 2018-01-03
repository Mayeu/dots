{
  allowUnfree = true;
  allowBroken = true;
  #build-use-chroot = true;

  #vim.python=true;

  packageOverrides = pkgs_ : with pkgs_; {
    my_neovim = import vim/customization.nix { inherit pkgs; };
    #corebird = import ./corebird.nix {inherit pkgs; inherit stdenv;};

    all = with pkgs; buildEnv {
      name = "all";

      paths = [
        heroku
        ledger
        jitsi
      ];
    };
  };
}
