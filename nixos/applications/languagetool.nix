# Thanks https://gist.github.com/CRTified/9d996a6a7c548ca42fa3672eee95da92
{ config, lib, pkgs, ... }: {
  environment.systemPackages = [
    pkgs.languagetool
  ];
  services.languagetool = {
    enable = true;
    allowOrigin = ""; # To allow access from browser addons
    settings = {
      # Allowed options:
      # https://github.com/languagetool-org/languagetool/blob/master/languagetool-server/src/main/java/org/languagetool/server/HTTPServerConfig.java#L185-L205

      # Optional, remove unneeded files
      # Approx. total of 26GB.
      # Data from:
      # https://languagetool.org/download/ngram-data/
      languageModel = pkgs.linkFarm "languageModel"
        (builtins.mapAttrs (_: v: pkgs.fetchzip v) {
          en = { # 15GB
            url =
              "https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip";
            hash = "sha256-v3Ym6CBJftQCY5FuY6s5ziFvHKAyYD3fTHr99i6N8sE=";
          };
        });

      fasttextBinary = "${pkgs.fasttext}/bin/fasttext";
      # Optional, but highly recommended
      # Data from:
      # https://fasttext.cc/docs/en/language-identification.html
      # 131 MB
      fasttextModel = pkgs.fetchurl {
        name = "lid.176.bin";
        url =
          "https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin";
        hash = "sha256-fmnsVFG8JhzHhE5J5HkqhdfwnAZ4nsgA/EpErsNidk4=";
      };

      # All files mandatory
      # Data from:
      # https://languagetool.org/download/word2vec/
      word2vecModel = pkgs.linkFarm "word2vec"
        (builtins.mapAttrs (_: v: pkgs.fetchzip v) {
          en = { # 83M
            url = "https://languagetool.org/download/word2vec/en.zip";
            hash = "sha256-PAR0E8qxHBfkHYLJQH3hiuGMuyNF4cw9UbQeXVbau/A=";
          };
        });
      pipelinePrewarming = true;
    };
  };
}
