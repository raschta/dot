{ config, pkgs, lib, ... }:

{
    home-manager.users.dom={ config, pkgs, lib, ... }: {
        imports=[
            ./hypr
            ./waybar
            ./zsh
            ./wofi
        ];

        home.stateVersion="23.11";
        home.packages=[ ];
        home.username="dom";
        home.homeDirectory="/home/dom";
        nixpkgs.config.allowUnfree=true;
        programs.home-manager.enable=true;

        programs.bash.enable=true;
        wayland.windowManager.hyprland.systemd.variables=["--all"];
        home.sessionVariables.GTK_THEME = "adwaita-dark";

        dconf = {
            enable = true;
            settings = {
                "org/gnome/desktop/interface" = {
                    color-scheme = "prefer-dark";
                };
            };
        };

        programs.git={
            enable=true;
            userName ="Dominik Rastner";
            userEmail="dominik.rastner@gmail.com";
        };

        gtk={
            enable=true;
            theme.name="Adwaita-dark";
            iconTheme.name="Adwaita-dark";
            cursorTheme.name="Adwaita-dark";
        };

        qt={
            enable=true;
            style.name="adwaita-dark";
        };

        # gtk={
        #     enable=true;
        #     theme={
        #         package=pkgs.adw-gtk3;
        #         name="Adwaita-dark";
        #     };
        #     iconTheme={
        #         name="Adwaita-dark";
        #         package=pkgs.gnome.adwaita-icon-theme;
        #     };
        #     cursorTheme = {
        #         name="Adwaita-dark";
        #         package=pkgs.gnome.adwaita-icon-theme;
        #     };
        # };

        # qt={
        #     enable=true;
        #     platformTheme="gnome";
        #     style={
        #         name="adwaita-dark";
        #         package=pkgs.adwaita-qt;
        #     };
        # };
    };
}