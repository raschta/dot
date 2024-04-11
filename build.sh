[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
cp -r * /etc/nixos
nix-channel --add https://channels.nixos.org/nixos-unstable nixos
nix-channel --update
nixos-rebuild switch --upgrade