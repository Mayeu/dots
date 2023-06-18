#!/usr/bin/env bash

# This script WILL delete your data indiscriminatly without prompting you.
# It's not a bug, that's the whole point.

echo "🔄 Restore the original bashrc & zshrc"
sudo rename -fx /etc/*.backup-before-nix

echo "🧹 Remove the fstab entry for /nix"
sudo sed -i.bak -e '/nix apfs/d' -e '/^$/d' /etc/fstab

echo "🧹 Remove the synthetic entry for nix"
sed -i.bak '/nix/d' /etc/synthetic.conf

echo "🧹 Stop and remove the nix daemon service"
launchctl unload /Library/LaunchDaemon/org.nixos.nix-daemon.plist
rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
launchctl unload /Library/LaunchDaemons/org.nixos.activate-system.plist
rm /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo launchctl bootout system/org.nixos.darwin-store
rm /Library/LaunchDaemons/org.nixos.darwin-store.plist

echo "🧹 Remove the files created by nix"
rm -rf \
  /etc/nix /var/root/.nix-profile \
  /var/root/.nix-defexpr \
  /var/root/.nix-channels \
  ~/.nix-profile \
  ~/.nix-defexpr \
  ~/.nix-channels

echo "🛑 Remove the groups created by nix"
dscl . delete /Groups/nixbld
for i in $(seq 1 32); do sudo dscl . -delete /Users/_nixbld$i; done

echo "🧹 Remove the nix store volume"
umount /nix
diskutil apfs deleteVolume /nix
diskutil apfs deleteVolume "Nix Store"
rm -rf /nix/

echo "🐈 Now reboot your computer KTHXBYE"
