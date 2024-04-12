{ config, pkgs, lib, ... }:

{
    programs.wofi = {
        enable = true;
        settings.stylesheet = "/home/dom/.config/wofi/style.css";
    };
    home.file.".config/wofi/style.css".source = ./style.css;
}