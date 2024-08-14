{ config, pkgs, lib, ... }:

{
    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file."bg.png" = { source = ../bg.png; force = true; };
}