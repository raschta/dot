{ config, pkgs, lib, ... }:

{
    imports  = 
        [
            ./hardware-configuration.nix
            (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz}/nixos")
            ./home.nix
        ];

    # systemd
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # grub
    # boot.loader.grub.enable = true;
    # boot.loader.grub.device = "/dev/sda";
    # boot.loader.grub.useOSProber = true;

    # environment.variables.WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
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

    console = {
        earlySetup = true;
        font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
        packages = with pkgs; [ terminus_font ];
        keyMap = "de";
    };

    users.users.dom = {
        isNormalUser = true;
        initialPassword = "install";
        description = "Dominik Rastner";
        extraGroups = [ "networkmanager" "wheel" "ftp_user" "vboxsf" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
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
        xdg-utils
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        pavucontrol
        pipewire
        dunst
        kitty
        foot
        zsh
        networkmanagerapplet
        home-manager
        htop

        firefox
        dolphin
        vlc

        vscode
        python3
        gcc
        git
        cmake
        shaderc
        libpng
        vulkan-validation-layers
    ];
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    ];

    services.openssh.enable = true;

    services.dbus.enable = true;
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-hyprland
        ];
    };

    networking.firewall.allowedTCPPorts = [21];
    services.vsftpd = {
        enable = true;
        writeEnable = true;
        localUsers = true;
        userlistEnable = true;
        userlist = ["ftp_user"];
    };
    environment.sessionVariables = rec {
        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";

        XDG_BIN_HOME    = "$HOME/.local/bin";
        PATH = [ 
            "${XDG_BIN_HOME}"
        ];

        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
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
    programs.zsh.enable = true;
    programs.firefox = {
        enable = true;
        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            DontCheckDefaultBrowser = true;
            DisablePocket = true;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DisplayBookmarksToolbar = "never";
            Preferences = {
                "widget.use-xdg-desktop-portal.file-picker" = 1;
                "browser.aboutConfig.showWarning" = false;
                "browser.compactmode.show" = true;
                "browser.cache.disk.enable" = false;
                "widget.disable-workspace-management" = true;
                "browser.startup.page" = 3;
                "network.trr.mode" = 3;
                "browser.translations.automaticallyPopup" = false;
            };
        };
    };

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
}
