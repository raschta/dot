{ config, pkgs, lib, ... }:

{
    imports =
        [
            ./hardware-configuration.nix
            (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz}/nixos")
            ./home.nix
        ];

    # systemd
    # boot.loader.systemd-boot.enable=true;
    # boot.loader.efi.canTouchEfiVariables=true;

    # grub
    boot.loader.grub.enable=true;
    boot.loader.grub.device="/dev/sda";
    boot.loader.grub.useOSProber=true;

    environment.variables.WLR_RENDERER_ALLOW_SOFTWARE="1";
    environment.variables.WLR_NO_HARDWARE_CURSORS="1";
    # virtualisation.virtualbox.guest.enable=true;
    # virtualisation.virtualbox.guest.x11=true;

    networking.hostName="nixos";
    networking.networkmanager.enable=true;

    time.timeZone="Europe/Rome";

    i18n.defaultLocale="en_US.UTF-8";

    i18n.extraLocaleSettings={
        LC_ADDRESS="de_IT.UTF-8";
        LC_IDENTIFICATION="de_IT.UTF-8";
        LC_MEASUREMENT="de_IT.UTF-8";
        LC_MONETARY="de_IT.UTF-8";
        LC_NAME="de_IT.UTF-8";
        LC_NUMERIC="de_IT.UTF-8";
        LC_PAPER="de_IT.UTF-8";
        LC_TELEPHONE="de_IT.UTF-8";
        LC_TIME="de_IT.UTF-8";
    };

    console.keyMap="de";

    users.users.dom={
        isNormalUser=true;
        initialPassword="install";
        description="Dominik Rastner";
        extraGroups=[ "networkmanager" "wheel" "ftp_user" "vboxsf" ];
        packages=with pkgs; [];
        shell=pkgs.zsh;
    };

    environment.systemPackages=with pkgs; [
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
        foot
        zsh
        networkmanagerapplet
        home-manager
        htop
        nerdfonts

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

    services.openssh.enable=true;

    networking.firewall.allowedTCPPorts=[21];
    services.vsftpd={
        enable=true;
        writeEnable=true;
        localUsers=true;
        userlistEnable=true;
        userlist=["ftp_user"];
    };

    # services.xserver.enable=true;
    # services.xserver.displayManager.sddm.enable=true;
    # services.xserver.displayManager.sddm.wayland.enable=true;
    # services.xserver.displayManager.sddm.settings={
    #     Theme={
    #         Current="breeze";
    #         ThemeDir="/sddmt";
    #     };
    # };
    programs.hyprland.enable=true;
    programs.zsh.enable=true;

    sound.enable=true;
    security.rtkit.enable=true;
    services.pipewire={
        enable=true;
        alsa.enable=true;
        alsa.support32Bit=true;
        pulse.enable=true;
    };

    system.stateVersion="23.11";
    nixpkgs.config.allowUnfree=true;

    nix.gc={
        automatic=true;
        dates="weekly";
    };

    system.autoUpgrade={
        enable=true;
        dates="weekly";
        allowReboot=true;
    };
}
