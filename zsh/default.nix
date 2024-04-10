{ config, pkgs, lib, ... }:

{
    programs.zsh={
        enable=true;
        autocd=true;
        enableCompletion=true;
        enableAutosuggestions=true;
        syntaxHighlighting.enable=true;

        oh-my-zsh={
            enable=true;
            theme="agnoster";

            plugins=[
                "command-not-found"
                "git"
                "history"
                "sudo"
            ];
        };

        initExtra=''
            # ALT+a to accept completion
            bindkey '^[a' autosuggest-accept
            # ALT+e to accept and execute
            bindkey '^[e' autosuggest-execute
        '';

        history={
            save=1000;
            size=1000;
            path="$HOME/.cache/zsh_history";
            expireDuplicatesFirst=true;
        };
    };
}