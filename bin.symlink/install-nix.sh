#!/usr/bin/env bash

cd ~/ && git clone https://github.com/Mayeu/dots .dots

#echo "📦 Installing nix"
sh <(curl -L https://nixos.org/nix/install)

echo "⤴️ Loading nix"
source /etc/static/bashrc

echo "🚇 Adding my channels"
nix-channel --add https://channels.nixos.org/nixpkgs-22.11-darwin nixpkgs
nix-channel --add https://channels.nixos.org/nixpkgs-unstable unstable
nix-channel --update

# cat <<EOF | sudo tee -a /etc/nix/nix.conf
# substituters = https://cache.nixos.org/ ${{ secrets.S3_URL }}
# trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= mdots:h40b7TWhz9PqO04aqOAiAEEdulJ2Q9oJ3MxXQCgQVvs=
# post-build-hook = /etc/nix/upload-to-cache.sh
# EOF

echo "😈 Install nix-darwin"
tmp=$(mktemp -d)

cd "$tmp"

export NIX_CONF="binary-caches=s3://mdots?endpoint=https://s3.fr-par.scw.cloud/"

nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer --extra-substituters 's3://mdots?endpoint=https://s3.fr-par.scw.cloud/'

echo "🔨 Building my system"
# Don't think the source is needed here
source /etc/static/bashrc
darwin-rebuild switch
