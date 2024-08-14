{ pkgs }:

pkgs.stdenv.mkDerivation {
    name = "gruvbox-plus";
    src = pkgs.fetchurl {
        url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v5.3/gruvbox-plus-icon-pack-5.3.zip";
        sha256 = "mq7Kooz9aDQcHtrNWsAXIurzUE6ZNaa6oRFFhYCaMpQ=";
    };

    dontUnpack = true;

    installPhase = ''
        mkdir -p $out
        ${pkgs.unzip}/bin/unzip $src -d $out/
    '';
}
