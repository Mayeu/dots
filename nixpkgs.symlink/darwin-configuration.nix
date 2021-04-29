{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # This overlays the default nixpkgs
  # In this case, it's only for the  vim_configurable package (used in the programs.vim),
  # so that it is built with gui support but with darwin support.
  # This is mostly to fix the clipboard issue.
  #
  # This
  # https://github.com/hardselius/dotfiles/blob/98691fc1e8d664765a4840361a839d10c5bb2c9c/overlays/20-vim.nix,
  # and
  # https://github.com/a-h/dotfiles/commit/dd56c35908958a4abf727ab590421b93b071486e
  # helped we get the lightbulb moment.
  nixpkgs.overlays = [
    (self: pkgs: {
      vim_configurable = pkgs.vim_configurable.override {
        #python = pkgs.python3;
        guiSupport = "no";
        darwinSupport = true;
      };
    }
    )
  ];

  programs.vim = {
    enable = true;
    enableSensible = true;

    plugins = [
      {
        names = [
          "vim-nix" "vim-addon-nix" # For Nix
          "editorconfig-vim"
          "gruvbox" # My fav theme
          "ale" # ALE (linting, syntax error, fix on save)
          "vim-yaml"
          "vim-terraform" "vim-terraform-completion"
          "vim-ruby"
        ]; }
      ];

      vimConfig = ''
        " Define my leader key as SPC
        let mapleader=" "

        " Basic settings --------------------------
        " Use the system clipboard by default.
        set clipboard^=unnamed

        " More natural split
        set splitbelow
        set splitright

        " Colors & colorscheme --------------------
        set termguicolors
        set background=light   " Setting light mode
        colorscheme gruvbox

        " ALE:
        let g:ale_sign_error = 'X'
        let g:ale_sign_warning = '!'
        highlight link ALEWarningSign ErrorMsg
        highlight link ALEErrorSign WarningMsg
        nnoremap <silent> <leader>ne :ALENextWrap<CR>
        nnoremap <silent> <leader>pe :ALEPreviousWrap<CR>

        let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'javascript': ['prettier'],
            \   'javascript.jsx': ['prettier'],
            \   'typescript': ['prettier'],
            \   'json': ['prettier'],
            \   'scss': ['prettier'],
            \   'ruby': ['rubocop'],
            \   'bash': ['shfmt'],
            \   'sh': ['shfmt'],
            \   'zsh': ['shfmt'],
            \   'elixir': ['mix_format'],
            \   'terraform': ['terraform'],
            \}

        let g:ale_fix_on_save = 1

        " Terraform config ------------------------
        " Currently there is no good hcl plugins, so I use terraform for syntax highlight
        autocmd BufRead,BufNewFile *.hcl set filetype=terraform
        autocmd BufRead,BufNewFile *.tf set filetype=terraform

        " Shell config ----------------------------
        autocmd FileType zsh setlocal expandtab shiftwidth=2 softtabstop=0 syn=sh ft=sh
      '';

    };
  }
