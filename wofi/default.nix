{ config, pkgs, lib, ... }:

{
    programs.wofi={
        enable=true;
        settings.stylesheet="/home/dom/.config/wofi.css";
    };
    home.file.".config/wofi.css".source=./wofi.css;
}