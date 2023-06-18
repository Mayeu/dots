{pkgs}: let
  my_plugins = pkgs.callPackage ./plugins.nix {};
  vimConfig = {
    customRC = builtins.readFile ~/.vimrc;
    packages.knownPlugins = pkgs.vimPlugins // my_plugins; # optional
    packages.pluginDictionaries = [
      # load always
      {
        names = [
          # Theme
          #"Solarized" # Theme
          "gruvbox" # Theme

          # UI
          "vim-airline"

          # Tools
          "fugitive" # Tpope git stuff
          "UltiSnips" # Snippets
          "vim-snippets" # Snippets
          "vim-dispatch" # Async adapter by tpope
          "vim-dispatch-neovim"
          "vim-projectionist" # Project management
          "Syntastic" # Syntax checking

          # Lang
          "vim-nix" #
          "vim-elixir"
          "vim-phoenix"
          "vim-ledger"
          "vim-ruby"
        ];
      }
      # only load when opening a .nix file
      #{ name = "vim-nix"; ft_regex = "^nix\$"; }
      #{ name = "vim-nix"; filename_regex = "^.nix\$"; }
      ## provide plugin which can be loaded manually:
      #{ name = "phpCompletion"; tag = "lazy"; }
    ];
  };
in
  pkgs.neovim.override {
    vimAlias = true;
    configure = vimConfig;
  }
