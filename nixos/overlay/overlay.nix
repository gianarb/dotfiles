{}: self: super:
{
  weechat-edit = self.callPackage ./weechat-edit { };
  hll2375dw-cups = self.callPackage ./hll2375dw-cups { };
  wee-slack = super.weechatScripts.wee-slack.overrideAttrs (
    x: rec {
      version = "a4e1c79d3bffa82628bcb91a4121ed5f7600d1e1";
      src = super.fetchFromGitHub {
        owner = "wee-slack";
        repo = "wee-slack";
        rev = "a4e1c79d3bffa82628bcb91a4121ed5f7600d1e1";
        sha256 = "sha256-cp6vdLzK+0hKRs/wtvvmIGzdhSv37Vy1X1IlOmxWOEY=";
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
