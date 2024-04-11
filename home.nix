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
        home.packages = [ ];
        home.username = "dom";
        home.homeDirectory = "/home/dom";
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
            theme = {
                name = "Materia-dark";
                package = pkgs.materia-theme;
            };
        };

        qt = {
            enable = true;
            platformTheme = "gnome";
            style.name = "adwaita-dark";
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