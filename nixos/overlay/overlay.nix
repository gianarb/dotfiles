{}: self: super:
{
  weechat-edit = self.callPackage ./weechat-edit { };
  hll2375dw-cups = self.callPackage ./hll2375dw-cups { };
  wee-slack = self.callPackage ./wee-slack { };
  weechat = super.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with super.weechatScripts; [
        weechat-autosort
        self.wee-slack
        self.weechat-edit
      ];
    };
  };
}
