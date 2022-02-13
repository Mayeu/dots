{ config, pkgs, lib, ... }:
let
  # Use nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable to add it
  unstable = import <unstable> {};

  # A list of custom plugins for vim
  vimCustomPlugins = {
    # Exemple:
    #vim-selecta = pkgs.vimUtils.buildVimPlugin {
    #  name = "vim-selecta";
    #  src = pkgs.fetchFromGitHub {
    #    owner = "paulbellamy";
    #    repo = "selecta.nvim";
    #    rev ="3e3ebc0b302785bcecd5ec32c9c74c803d441a50";
    #    sha256 = "dmYL1GNyAIYyTOrhQm293tF19licm/Kix0kC5KkTi7Y=";
    #  };
    #};
    # use nix-prefetch-github to have those info
  };

  # This fetch a tarball containing a default.nix and use it as package later on.
  # The {} is the magic that correctly turn it into a package
  comma = import (
    # TODO: the nix used in this emit warning about flakes support. Try to fix
    pkgs.fetchFromGitHub {
      owner = "DavHau";
      repo = "comma";
      rev = "7eca596248e8d808617103d0eb515074b994bff0";
      sha256 = "F95bKzwc/9hhhvzNW3OX9TBeUnq89ZhebYFS2Q1mrc8=";
      fetchSubmodules = true;
    }) {};

in
  {
    environment.variables.LC_ALL = "en_US.UTF-8";
  # TODO: date format, local money?

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    comma
    nix-prefetch-github
    exiftool
    mosh
    tree
    git
    git-extras
    git-subrepo
    unstable.git-secret # Unstable to get 0.4
    diff-so-fancy # Fancy diff for git
    fzf
    antibody
    bash
    wget
    curl
    unstable.terraform # Necessary because on stable TF is 0.12 🤦
    terragrunt
    nomad
    rsync
    ripgrep
    unstable.elixir
    bat
    jq
    python39Packages.weboob
    unstable.yt-dlp
    ffmpeg
    tmux
    shellcheck
    mysql-client
    borgbackup
    #borgmatic # Currently broken on macos
    #reptyr # Reattach a orphan process to the terminal. Linux only :(
    unstable.k9s
    dhall
    dhall-json
    dhall-lsp-server
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-live
    #kube3d # Don't support macOS in nix apparently
    tfk8s
    broot # https://dystroy.org/broot/
    #t # A command-line power tool for Twitter. Commented because I'm not sure it match my usecase
    yq # Command line yaml processor, like jq
    silver-searcher # Similar to ack, but faster
    tldr # simplified community driven man pages
    packer
    vagrant
    #kubectl
    #kubernetes-helm
    gnumake
    gopass
    pass
    fd # alternative to find
    direnv # Automate env loading, but more importently, nix shell loading
    rclone
    unstable.nix-direnv # 2021-12-28: at that time the flake option is only in unstable
    sshuttle
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";


  # Add those path to the current system
  # TODO: use this for broot as well. Maybe? Direct link to derivation could be better no?
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  services.nix-daemon.enable = true;

  # nix.package = pkgs.nix;
  nix = {
    #package = pkgs.nixUnstable;
    #package = pkgs.nixFlakes;
    package = unstable.nix; # Necessary to get >=2.5, with Flake support.

    binaryCaches = ["s3://mdots?endpoint=https://s3.fr-par.scw.cloud/&region=fr-par"];
    binaryCachePublicKeys = ["mdots-1:h40b7TWhz9PqO04aqOAiAEEdulJ2Q9oJ3MxXQCgQVvs="];

    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      keep-failed = true
      keep-going = true
    '';
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
  };
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  programs.gnupg = {
    agent.enable = true;
    agent.enableSSHSupport = true;
  };

  # Setup Path for GUI app, so they correctly find my app installed via Nix
  #launchd.user.envVariables.PATH = config.environment.systemPath;

  # This don't work, because the config is loaded after the Dock & Spotlight.
  # But we can't make it a system thing, because $HOME don't make sense at the system level
  #launchd.user.agents.test-env = {
  #  serviceConfig.ProgramArguments = [
  #    "${pkgs.zsh}/bin/zsh"
  #    "-c"
  #    "launchctl setenv PATH ${config.environment.systemPath}"
  #  ];
  #  serviceConfig.RunAtLoad = true;
  #  serviceConfig.StandardOutPath = "/tmp/test.log";
  #};

  # This don't work either
  #launchd.agents.test-env = {
  #  serviceConfig.ProgramArguments = [
  #    "launchctl"
  #    "setenv"
  #    "PATH"
  #    "/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin"
  #  ];
  #  serviceConfig.RunAtLoad = true;
  #  serviceConfig.StandardOutPath = "/tmp/test.log";
  #};

  # The only way to setup the GUI path variable > Catalina is by using:
  # launchctl config system path /run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
  # (same for user).
  # The pb is that it does require a reboot to work
  # Via: https://stackoverflow.com/a/3756686

  # This overlays the default nixpkgs
  # In this case, it's only for the  vim_configurable,_ package (used in the programs.vim),
  # so that it is built without gui support but with darwin support.
  # This fix the clipboard issue on macOS wich require darwin support.
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

      nix-direnv = pkgs.nix-direnv.override { enableFlakes = true; };
    }
    )
  ];

  programs.vim = {
    enable = true;

    extraKnownPlugins = vimCustomPlugins;
    plugins = [
      {
        names = [
          "vim-sensible" # Sensible default for VIM by tpope
          "vim-eunuch" # :Move, Rename, etc.
          "vim-surround"
          "vim-nix" "vim-addon-nix" # For Nix
          "editorconfig-vim"
          "gruvbox" # My fav theme
          "ale" # ALE (linting, syntax error, fix on save)
          "vim-yaml"
          "vim-terraform" "vim-terraform-completion"
          "vim-ruby"
          "auto-pairs" # Auto close pairs character
          "fzfWrapper"
          "coc-nvim" # Fancy auto completion and stuff, include nodejs
          "fzf-vim"
          "coc-fzf"
          "vim-elixir"
          "tabmerge"
          "dhall-vim"
          "LanguageClient-neovim"
          "elm-vim"
        ];
      }
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

        " Tab management
        " `ca` for `:cabbrev` which abreviate command-line mode command only
        ca tn tabnew
        ca th tabp
        ca tl tabn
        ca tc tabclose

        " Line numbering
        " This turn hybrid line numbers on, by turning both number &
        " relativenumber on by default
        " Then, we define an autocommand to use relative number line only in
        " the currently focused buffer and out of insert mode
        set number relativenumber

        augroup numbertoggle
          autocmd!
          autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
          autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
        augroup END

        "Sudo Write
        "
        " `command`: create a command
        " `W`: the new command name
        command W w !sudo tee "%" > /dev/null

        " Colors & colorscheme --------------------
        set termguicolors
        set background=dark
        colorscheme gruvbox

        "Shell
        set shell=${pkgs.zsh}/bin/zsh

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

        " FzF configuration -------------------
        nmap <leader><space> :Files<CR>

        " Default hotkeys
        "nmap <leader>ff <Plug>(selecta-file)
        "nmap <leader>fv :vnew<CR><Plug>(selecta-file)
        "nmap <leader>fh :new<CR><Plug>(selecta-file)
        "nmap <leader>b <Plug>(selecta-buffer)

        " LanguageClient-neovim ------------------
        " TODO: Consider removing CoC and only using this?

        let g:LanguageClient_serverCommands = {
          \ 'dhall': ['dhall-lsp-server'],
          \ }

        " comment the next line to disable automatic format on save
        let g:dhall_format=1

        " Always draw sign column. Prevent buffer moving when adding/deleting sign.
        set signcolumn=yes

        " Required for operations modifying multiple buffers like rename.
        set hidden
    '';

  };
}
