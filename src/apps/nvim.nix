{
  config,
  pkgs,
  ...
}:
pkgs.neovim.override {
  vimAlias = true;
  configure = {
    packages.myPlugins = with pkgs.vimPlugins; {
      start = [
        lualine-nvim
        (nvim-treesitter.withPlugins (
          plugins:
            with plugins; [
              nix
              elixir
              ruby
              bash
              dockerfile
              erlang
              gitignore
              hcl
              json
              markdown
              toml
              yaml
              lua
            ]
        ))
      ];
      opt = [];
    };

    customRC = ''
      lua require('lualine').setup()
    '';
  };
}
