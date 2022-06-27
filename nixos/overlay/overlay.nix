{}: self: super:
{
  weechat-edit = self.callPackage ./weechat-edit { };
  hll2375dw-cups = self.callPackage ./hll2375dw-cups { };
  microcodeIntel = super.microcodeIntel.overrideAttrs (
    x: rec {
      version = "20210608";
      src = super.fetchFromGitHub {
        owner = "intel";
        repo = "Intel-Linux-Processor-Microcode-Data-Files";
        rev = "microcode-${version}";
        sha256 = "sha256-oydbpJyf0psy0ykfmQF3dOfnrnK6YVGX1JhR8UcZ0yI=";
      };
    }
  );
  weechat = super.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with super.weechatScripts; [
        weechat-matrix
        #weechat-otr
        wee-slack
        weechat-autosort
        self.weechat-edit
      ];
    };
  };
  rust-analyzer = super.rust-analyzer.overrideAttrs (
    x: rec {
      version = "2022-02-28";
      cargoSha256 = "sha256-dTw6xp99uGtGp6YuqAX3r3GDD6Wto3KHTaO2DUUE2FA=";
      RUST_ANALYZER_REV = "2022-02-28";

      src = super.fetchFromGitHub {
        owner = "rust-analyzer";
        repo = "rust-analyzer";
        rev = "2022-02-28";
        sha256 = "sha256-GQ1cPO4povnozLl0MTFs0ZXpmBn+AZeFWQVnxHHWf9g=";
      };
    }
  );
}
