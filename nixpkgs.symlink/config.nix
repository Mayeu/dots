{
  allowUnfree = true;
  allowBroken = true;

  packageOverrides = pkgs_ : with pkgs_; {
    my_neovim = import vim/customization.nix { inherit pkgs; };

    all = with pkgs; buildEnv {
      name = "all";

      paths = [
        #borgbackup
        #mblaze
      ];
    };
  };
}
