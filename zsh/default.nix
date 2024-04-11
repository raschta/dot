{ config, pkgs, lib, ... }:

{
    programs.zsh = {
        enable = true;
        autocd = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
            enable = true;
            theme = "agnoster";

            plugins = [
                "command-not-found"
                "git"
                "history"
                "sudo"
            ];
        };

        initExtra = ''
            DEFAULT_USER=$(whoami)
            bindkey '^[a' autosuggest-accept
            bindkey '^[r' autosuggest-execute
        '';

        history = {
            save = 1000;
            size = 1000;
            path = "$HOME/.cache/zsh_history";
            expireDuplicatesFirst = true;
        };
    };
}