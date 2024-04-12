{ config, pkgs, lib, ... }:

{
    home-manager.users.dom = { config, pkgs, lib, ... }: {
        imports = [
            ./hypr
            ./waybar
            ./zsh
            ./wofi
        ];

        home.stateVersion = "23.11";
        home.packages = [ (pkgs.callPackage ./gruvbox-plus {}) ];
        home.username = "dom";
        home.homeDirectory = "/home/dom";

        # home.file.".config/gtk-3.0/gtk.css" = { source = ./gtk.css; force = true; };
        # home.file.".config/gtk-4.0/gtk.css" = { source = ./gtk.css; force = true; };

        nixpkgs.config.allowUnfree = true;
        programs.home-manager.enable = true;
        programs.bash.enable = true;

        programs.firefox = {
            enable = true;
            profiles = {
                default = {
                    id = 0;
                    name = "default";
                    isDefault = true;
                    search = {
                        default = "DuckDuckGo";
                        force = true;
                    };
                };
            };
        };
        programs.kitty = {
            enable = true;
            font.name = "RobotoMono Nerd Font";
        };
        programs.foot.settings = {
            enable = true;
            settings = {
                main = {
                    dpi-aware = "yes";
                    font = "RobotoMono Nerd Font";
                };
                mouse = {
                    hide-when-typing = "yes";
                };
            };
        };

        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "text/html" = "org.qutebrowser.qutebrowser.desktop";
                "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
                "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
                "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
                "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
            };
        };

        wayland.windowManager.hyprland.systemd.variables = ["--all"];
        home.sessionVariables.GTK_THEME = "adwaita-dark";

        dconf = {
            enable = true;
            settings = {
                "org/gnome/desktop/interface" = {
                    color-scheme = "prefer-dark";
                };
            };
        };

        programs.git = {
            enable = true;
            userName  = "Dominik Rastner";
            userEmail = "dominik.rastner@gmail.com";
        };

        gtk = {
            enable = true;
            cursorTheme.package = pkgs.bibata-cursors;
            cursorTheme.name = "Bibata-Modern-Ice";

            theme.package = pkgs.adw-gtk3;
            theme.name = "adw-gtk3";

            iconTheme.package = pkgs.gruvbox-plus;
            iconTheme.name = "GruvboxPlus";
            # theme = {
            #     name = "Materia-dark";
            #     package = pkgs.materia-theme;
            # };
        };

        qt = {
            enable = true;
            platformTheme = "gtk";
            style.name = "adwaita-dark";
            style.package = pkgs.adwaita-qt;
        };

        # gtk = {
        #     enable = true;
        #     theme = {
        #         package = pkgs.adw-gtk3;
        #         name = "Adwaita-dark";
        #     };
        #     iconTheme = {
        #         name = "Adwaita-dark";
        #         package = pkgs.gnome.adwaita-icon-theme;
        #     };
        #     cursorTheme = {
        #         name = "Adwaita-dark";
        #         package = pkgs.gnome.adwaita-icon-theme;
        #     };
        # };

        # qt = {
        #     enable = true;
        #     platformTheme = "gnome";
        #     style = {
        #         name = "adwaita-dark";
        #         package = pkgs.adwaita-qt;
        #     };
        # };
    };
}