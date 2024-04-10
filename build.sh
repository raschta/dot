[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
cp -r * /etc/nixos
nixos-rebuild switch