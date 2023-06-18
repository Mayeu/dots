{
  pkgs,
  fetchgit,
}: let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in {
  "vim-dispatch" = buildVimPlugin {
    name = "vim-dispatch";
    src = fetchgit {
      url = "git://github.com/tpope/vim-dispatch";
      rev = "fc8d1e68cd58fb3ffdd56109bf855cda92b10b70";
      sha256 = "1l3a8p9678lip5yy9aj5xayj964kfblmw3palivhwy040b4wsc5b";
    };
  };

  "vim-dispatch-neovim" = buildVimPlugin {
    name = "vim-dispatch-neovim";
    src = fetchgit {
      url = "git://github.com/radenling/vim-dispatch-neovim";
      rev = "85deb470b53ab796e6201b3345de588f1d648555";
      sha256 = "0flkx0fcwnqxq5m80cv7qzglgh5f1699gl61xa3s52pi5ianyps5";
    };
    dependencies = ["vim-dispatch"];
  };

  "vim-elixir" = buildVimPlugin {
    name = "vim-elixir";
    src = fetchgit {
      url = "git://github.com/elixir-lang/vim-elixir";
      rev = "fe61852c744627394c8845925dfba39aa6ac1ca4";
      sha256 = "185knyy4izwphip5rw68ia21n23s15nry1afqrzwy74gs2bwcya6";
    };
  };

  "vim-projectionist" = buildVimPlugin {
    name = "vim-projectionist";
    src = fetchgit {
      url = "git://github.com/tpope/vim-projectionist";
      rev = "372d529d22ac6d2952472438157ee03b7a3fd8ae";
      sha256 = "1i5fbs5cammjb8r53fwds4g9k2vjhh5shrm5j2y8lcsxcil1zr21";
    };
  };

  "vim-phoenix" = buildVimPlugin {
    name = "vim-phoenix";
    src = fetchgit {
      url = "git://github.com/avdgaag/vim-phoenix";
      rev = "ad7b38db0903a969085bd5b39d4314a41f4c1345";
      sha256 = "09vidv3a177bqs25c9y3s0wjalqqxv203kshd7fkj42b3gjl09fx";
    };
    dependencies = ["vim-dispatch" "vim-elixir" "vim-projectionist"];
  };

  "vim-ledger" = buildVimPlugin {
    name = "vim-ledger";
    src = fetchgit {
      url = "git://github.com/ledger/vim-ledger";
      rev = "726359d582adf066905e01ec0081a6d028be97a2";
      sha256 = "1fmf2slgnkd022wal5wc9b200acvqlgwz1b4dm65cyb68cny7llr";
    };
  };

  #"vim-wiki" = buildVimPlugin {
  #  name = "vim-wiki";
  #  src = fetchgit {
  #    url = "git://github.com/vimwiki/vimwiki";
  #    rev = "3bd3d9b86036b21aecd69f0a1e572643d626c280";
  #    sha256 = "7a10ae3881af0d17a041ffd766680ceedf706411abbbedccf64e9e777fabd5c8";
  #  };
  #};

  "vim-ruby" = buildVimPlugin {
    name = "vim-ruby";
    src = fetchgit {
      url = "git://github.com/vim-ruby/vim-ruby";
      rev = "2412e023cb17d38f218ea07deeb9b8feedf80409";
      sha256 = "1hmq6q6ai964cg3ksm2k3syz1gc1y35pm5fwpq442mbxswq4l6rz";
    };
  };
}
