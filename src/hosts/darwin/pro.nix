{ config,
#pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/feda52be1d59.tar.gz") {},
pkgs,
lib,
m,
... }:
let

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

in
  {
    environment.variables.LC_ALL = "en_US.UTF-8";
  # TODO: date format, local money?

  # Show all files including hidden
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  # Show all extensions in filename
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  # Don't switch automatically between light and dark mode;
  system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
  # Deactivate character substitutions and most of the spelling automated fix
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  # No autosave to cloud
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  # Access F1, F2, ... with the Fn key
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = false;

  # Use units that make sense
  system.defaults.NSGlobalDomain.AppleMetricUnits = 1;
  system.defaults.NSGlobalDomain.AppleTemperatureUnit = "Celsius";
  system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;

  # Don't hide the menubar
  system.defaults.NSGlobalDomain._HIHideMenuBar = false;

  # Dock configuration
  system.defaults.dock.autohide = true;
  system.defaults.dock.show-process-indicators = true;
  system.defaults.dock.show-recents = false;
  #system.defaults.dock.mru-spaces = false;

  # Disable all control corner
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-bl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;
  system.defaults.dock.wvous-br-corner = 1;

  # Finder configuration
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder.ShowPathbar = true;
  # Change default search scope to currnt folder
  system.defaults.finder.FXDefaultSearchScope = "SCcf";
  # Change default view to list view
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  # Don't show any icons on the desktop
  system.defaults.finder.CreateDesktop = false;
  # Don't warn when changing the extension of a file
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  # Keyboard configuration
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Trackpad
  # No tap to click
  system.defaults.trackpad.Clicking = false;
  # No tap to drag
  system.defaults.trackpad.Dragging = false;

  # Custom system preferences
  system.defaults.CustomUserPreferences = {
    "org.gpgtools.common" = { "UseKeychain" = "NO"; };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    gnutar
    comma
    nix-prefetch-github
    exiftool
    mosh
    tree
    git
    git-extras
    git-subrepo
    git-bug
    diff-so-fancy # Fancy diff for git
    git-lfs
    fzf
    bash
    nushell
    wget
    curl
    rsync
    ripgrep
    bat
    jq
    yq-go # Command line yaml processor, like jq
    fq # jq for binaries
    #xmlstarlet # Command line xml processor
    python310Packages.woob
    yt-dlp
    ffmpeg
    tmux
    shellcheck
    borgbackup
    #borgmatic # Currently broken on macos
    broot # https://dystroy.org/broot/
    silver-searcher # Similar to ack, but faster
    vagrant
    gnumake
    gopass
    pass
    fd # alternative to find
    direnv # Automate env loading, but more importently, nix shell loading
    nix-direnv
    openssh
    sshuttle
    #jless # A JSON viewer in the cli
    pwgen
    pgcli
    upx
    pv
    shfmt
    ipfs
    lrzip
    coreutils
    pigz
    imagemagick
    picocom
    htop
    # siril # Not supported on macOS yet
    atomicparsley # Pour embedded les images dans les m4a de youtube-dl TODO: not sure it's needed with yt-dlp
    tor
    sshpass
    sshuttle
    # virtualboxWithExtpack # Not supported by macOS yet
    #ctags # Not sure I really need that as a root package
    #python2
    fswatch
    tealdeer
    rmlint
    fd
    watchexec
    smartmontools
    #kitty # Terminal emulator
    # Terminal emulator in rust, support Kitty img & iterm2
    #( wezterm.overrideAttrs (_: {
    #  meta.broken = false;
    #}))
    #gphoto2
    #python310Packages.pipx
    elixir_1_14 # until I pin my version and have cache, make it common for my projects using it.
    ntfs3g
    bindfs
    sshfs
    terminal-notifier
    testssl
    zsh-completions
    nix-zsh-completions
    nodejs # saddly, it's necessary for Vim's coc...
    m.packages.${pkgs.system}.default
    topgrade
  ];


  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Add those path to the current system
  # TODO: use this for broot as well. Maybe? Direct link to derivation could be better no?
  environment.pathsToLink = [
    "/share/nix-direnv"
    "/share/zsh"
    "/libexec"
  ];

  services.nix-daemon.enable = true;

  # nix.package = pkgs.nix;
  nix = {
    #package = pkgs.nixUnstable;
    #package = pkgs.nixFlakes;
    #package = unstable.nix; # Necessary to get >=2.5, with Flake support.

    settings = {
      substituters = ["s3://mdots?endpoint=https://s3.fr-par.scw.cloud/&region=fr-par"];
      trusted-public-keys = ["mdots:h40b7TWhz9PqO04aqOAiAEEdulJ2Q9oJ3MxXQCgQVvs="];
    };

    extraOptions = ''
      #auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      keep-failed = false
      keep-going = true
    '';
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableSyntaxHighlighting = true;

    promptInit = "";
    interactiveShellInit = ''
      source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      source "${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh"

      source "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
      source "${pkgs.spaceship-prompt}/lib/spaceship-prompt/spaceship.zsh"
      '';
  };
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # System defaults setting
  # it's not automagically setting those up. One as to dev them apparently
  #system.defaults."org.gpgtools.common".DisableKeychain = true;
  #system.defaults."org.gpgtools.common".UseKeychain = false;

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

      wezterm = pkgs.wezterm.override {
        buildInputs = with pkgs; [
          fontconfig
          inconsolata
          zlib
        ] ++ lib.optionals stdenv.isLinux [
          libX11
          libxcb
          libxkbcommon
          openssl
          wayland
          xcbutil
          xcbutilimage
          xcbutilkeysyms
          xcbutilwm # contains xcb-ewmh among others
        ] ++ lib.optionals stdenv.isDarwin [
          Cocoa
          CoreGraphics
          Foundation
          libiconv
        ] ++ (stdenv.isDarwin && (builtins.hasAttr "UserNotifications" darwin.apple_sdk.frameworks)) [
          darwin.apple_sdk.frameworks.UserNotifications
        ];

      };
    })
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
          "vim-elixir" "alchemist-vim"
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

        " Exit quickly from normal and insert
        nmap qq :wqa<CR>
        imap qq <ESC>:wqa<CR>
        " Replace esc by hh in insert
        imap hh <ESC>

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

        " Set Invisible character
        " nbsp: non breaking space
        " trail: trailling space
        set list
        set listchars=tab:▸\ ,nbsp:␣,trail:•

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
            \   'bats': ['shfmt']
            \}

        let g:ale_fix_on_save = 1

        " Terraform config ------------------------
        " Currently there is no good hcl plugins, so I use terraform for syntax highlight
        autocmd BufRead,BufNewFile *.hcl set filetype=terraform
        autocmd BufRead,BufNewFile *.tf set filetype=terraform

        " Shell config ----------------------------
        autocmd FileType zsh setlocal expandtab shiftwidth=2 softtabstop=0 syn=sh ft=sh

        " Bats config -----------------------------
        " Set the shfmt option on ALE to make it work with bats
        " Also set the filetype type to bats but use the bash syntax highlighting.
        " Inverting those two will not work, setting filetype after syntax override the
        " syntax highlighting
        autocmd BufRead,BufNewFile *.bats
                          \ let b:ale_sh_shfmt_options='-ln bats -i 4'
                          \ | setlocal filetype=bats syntax=bash

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