{}: self: super:
{
  weechat-edit = self.callPackage ./weechat-edit { };
  hll2375dw-cups = self.callPackage ./hll2375dw-cups { };
  rssnix = self.callPackage ./rssnix { };
  wee-slack = super.weechatScripts.wee-slack.overrideAttrs (
    oldAttrs: rec {
      version = "e610b39aee2d9a49d080924d47d96c5d140f66ac";
      src = super.fetchFromGitHub {
        inherit version;
        owner = "wee-slack";
        repo = "wee-slack";
        rev = version;
        sha256 = "sha256-Jl4DmehVdGzPu21zTmzb0Wv6CDt4iDulBj8pMPVxO/s=";
      };
    }
  );
  weechat = super.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with super.weechatScripts; [
        weechat-matrix
        weechat-autosort
        self.weechat-edit
        self.wee-slack
      ];
    };
  };
}
