{ pkgs }:

let
  my_plugins = pkgs.callPackage ./plugins.nix {};
  vimConfig = {
    customRC = builtins.readFile ~/.vimrc;
    vam.knownPlugins = pkgs.vimPlugins // my_plugins; # optional
    vam.pluginDictionaries = [
      # load always
      { names = [
        "idris-vim" "UltiSnips" "vim-snippets"
        "fugitive" "Solarized" "vim-airline"
        "Syntastic" "vim-nix" "vim-dispatch"
        "vim-dispatch-neovim" "vim-elixir"
        "vim-projectionist" "vim-phoenix"
        "vim-ledger" "vim-ruby"
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
  pkgs.neovim.override {vimAlias = true; configure = vimConfig;}
