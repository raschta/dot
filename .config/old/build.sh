# cd $(nix build nixpkgs#bibata-cursors --print-out-paths --no-link)
# nix run nixpkgs#exa -- --tree --level 4

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
cp -r * /etc/nixos
# nix-channel --add https://channels.nixos.org/nixos-unstable nixos
# nix-channel --update
nixos-rebuild switch --upgrade