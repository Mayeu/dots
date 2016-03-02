{ pkgs, fetchgit }:
let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {

  "vim-dispatch" = buildVimPlugin {
    name = "vim-dispatch";
    src = fetchgit {
      url = "https://github.com/tpope/vim-dispatch";
      rev = "8c68969463383fa2cab3047b995d3f6d52c0b562";
      sha256 = "7465ef3a50b79d9d60f7daa41323f7b092a7a74cecc3187db5ac8c9d4c0f88e7";
    };
  };

  "vim-dispatch-neovim" = buildVimPlugin {
    name = "vim-dispatch-neovim";
    src = fetchgit {
      url = "https://github.com/radenling/vim-dispatch-neovim";
      rev = "a937bb15f33c866fc4936de310b09aa0d98a4d1b";
      sha256 = "e652d75ed76e47cd06c38dd685d1f1b5ce0fb2a420c9c6c64fbbb0641744dc41";
    };
    dependencies = ["vim-dispatch"];
  };

  "vim-elixir" = buildVimPlugin {
    name = "vim-elixir";
    src = fetchgit {
      url = "https://github.com/elixir-lang/vim-elixir";
      rev = "85593b118bae081538943640648e5d57f22f0aba";
      sha256 = "c3ac43d793e27b0ce1d8e403fab16bca700613ea38e5821950a10803e5837fc3";
    };
  };

  "vim-projectionist" = buildVimPlugin {
    name = "vim-projectionist";
    src = fetchgit {
      url = "https://github.com/tpope/vim-projectionist";
      rev = "372d529d22ac6d2952472438157ee03b7a3fd8ae";
      sha256 = "2aedc05ba0b9eaddf51c234d006f053ebe1f0c14aad3965b4946e7165e55edd6";
    };
  };

  "vim-phoenix" = buildVimPlugin {
    name = "vim-phoenix";
    src = fetchgit {
      url = "https://github.com/c-brenn/vim-phoenix";
      rev = "520835b7d826bafc27f477b8df8c549fab6f3e2e";
      sha256 = "6bcc14c7c7e3f8f0f2e37120487688e0024ae0fcec939e4951a468aa94fd70da";
    };
    dependencies = ["vim-dispatch" "vim-elixir" "vim-projectionist"];
  };

  "vim-ledger" = buildVimPlugin {
    name = "vim-ledger";
    src = fetchgit {
      url = "https://github.com/ledger/vim-ledger";
      rev = "726359d582adf066905e01ec0081a6d028be97a2";
      sha256 = "ff9ec928a0f3f32ddf25fc24d2aea6bd10caa7477a84165d16510400f6cd463c";
    };
  };

  "vim-wiki" = buildVimPlugin {
    name = "vim-wiki";
    src = fetchgit {
      url = "https://github.com/vimwiki/vimwiki";
      rev = "3bd3d9b86036b21aecd69f0a1e572643d626c280";
      sha256 = "7a10ae3881af0d17a041ffd766680ceedf706411abbbedccf64e9e777fabd5c8";
    };
  };

  "vim-ruby" = buildVimPlugin {
    name = "vim-ruby";
    src = fetchgit {
      url = "https://github.com/vim-ruby/vim-ruby";
      rev = "666adb5bcdfb2d21572a58fcdf7545a26bac32a0";
      sha256 = "dd9a132562359c72787c5e54c573d14c46eadd048678c687a16f831e34bc6e16";
    };
  };
}
