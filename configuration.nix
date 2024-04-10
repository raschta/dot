{ config, pkgs, lib, ... }:

{
    imports =
        [
            ./hardware-configuration.nix
            (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz}/nixos")
        ];

    # systemd
    # boot.loader.systemd-boot.enable = true;
    # boot.loader.efi.canTouchEfiVariables = true;

    # grub
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    environment.variables.WLR_RENDERER_ALLOW_SOFTWARE = "1";
    environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.x11 = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Rome";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_IT.UTF-8";
        LC_IDENTIFICATION = "de_IT.UTF-8";
        LC_MEASUREMENT = "de_IT.UTF-8";
        LC_MONETARY = "de_IT.UTF-8";
        LC_NAME = "de_IT.UTF-8";
        LC_NUMERIC = "de_IT.UTF-8";
        LC_PAPER = "de_IT.UTF-8";
        LC_TELEPHONE = "de_IT.UTF-8";
        LC_TIME = "de_IT.UTF-8";
    };

    console.keyMap = "de";

    users.users.dom = {
        isNormalUser = true;
        initialPassword = "install";
        description = "Dominik Rastner";
        extraGroups = [ "networkmanager" "wheel" "ftp_user" ];
        packages = with pkgs; [];
    };

    environment.systemPackages = with pkgs; [
        meson
        wayland-protocols
        wayland-utils
        wl-clipboard
        wlroots
        hyprland
        waybar
        wofi
        swww
        xwayland
        pavucontrol
        pipewire
        dunst
        kitty
        zsh
        networkmanagerapplet
        home-manager

        firefox
        dolphin

        vscode
        python3
        gcc
        git
        cmake
        shaderc
        libpng
        vulkan-validation-layers
    ];

    services.openssh.enable = true;

    networking.firewall.allowedTCPPorts = [21];
    services.vsftpd = {
        enable = true;
        writeEnable = true;
        localUsers = true;
        userlistEnable = true;
        userlist = ["ftp_user"];
    };

    # services.xserver.enable = true;
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.displayManager.sddm.wayland.enable = true;
    # services.xserver.displayManager.sddm.settings = {
    #     Theme = {
    #         Current = "breeze";
    #         ThemeDir = "/sddmt";
    #     };
    # };
    programs.hyprland.enable = true;
    programs.waybar.enable = true;

    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    system.stateVersion = "23.11";
    nixpkgs.config.allowUnfree = true;

    nix.gc = {
        automatic = true;
        dates = "weekly";
    };
    system.autoUpgrade = {
        enable = true;
        dates = "weekly";
        allowReboot = true;
    };

    home-manager.users.dom = { config, pkgs, ... }: {
        home.stateVersion = "23.11";
        home.packages = [ ];
        home.username = "dom";
        home.homeDirectory = "/home/dom";
        nixpkgs.config.allowUnfree = true;
        programs.home-manager.enable = true;

        programs.bash.enable = true;

gtk = {
  enable = true;
  theme = {
    package = pkgs.adw-gtk3;
    name = "adw-gtk3";
  };
};

qt = {
  enable = true;
  platformTheme = "gnome";
  style = {
    name = "adwaita-dark";
    package = pkgs.adwaita-qt;
  };
};


        wayland.windowManager.hyprland = {
            enable = true;
            systemd.enable = true;
            extraConfig: ''
            
            ''
        };

        # wayland.windowManager.hyprland.settings = {
        #     exec-once = "swww init & swww img /home/dom/bg.jpg";
        #     monitor = ",preferred,auto,1";

        #     general = {
        #         gaps_in = 0;
        #         gaps_out = 0;
        #         border_size = 2;
        #         layout = "dwindle";
        #     };

        #     decoration = {
        #         rounding = 0;
        #         blur = {
        #             enabled = true;
        #             size = 3;
        #             passes = 1;
        #             vibrancy = 0.1696;
        #         };
        #         drop_shadow = false;
        #     };
                        
        #     input = {
        #         kb_layout = "de";
        #         follow_mouse = 1;
        #     };

        #     "$mod" = "SUPER";
        #     bind =
        #     [
        #         "$mod, f, exec, firefox"
        #         "$mod, e, exec, dolphin"
        #         "$mod, return, exec, kitty"
        #         "$mod, r, exec, wofi --show run --prompt=Run"
        #         "$mod, c, killactive"
        #         "$mod, space, togglefloating"
        #         "alt, tab, cyclenext"
        #     ];

        #     bindm = [
        #         "$mod, mouse:272, movewindow"
        #         "$mod, mouse:273, resizewindow"
        #         "$mod ALT, mouse:272, resizewindow"
        #     ];
        # };

        programs.git = {
            enable = true;
            userName  = "Dominik Rastner";
            userEmail = "dominik.rastner@gmail.com";
        };
    };
}
