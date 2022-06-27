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
}
