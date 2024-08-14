sudo cp -r . $HOME/
hyprctl reload
killall -SIGUSR2 waybar
