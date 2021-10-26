{ config, pkgs, ... }:
let
  extensions = (with pkgs.vscode-extensions; [
    ms-vsliveshare.vsliveshare
    matklad.rust-analyzer
    (pkgs.vscode-utils.buildVscodeExtension {
      vscodeExtUniqueId = "vadimcn.vscode-lldb";
      name = "vadimcn.vscode-lldb-1.6.7";
      src = pkgs.fetchurl {
        name = "vadimcn.vscode-lldb.zip";
        url =
          "https://github.com/vadimcn/vscode-lldb/releases/download/v1.6.7/codelldb-${pkgs.system}.vsix";
        sha256 = "sha256-ypVHn59slWOu+wQ+O7rNfMZBtZFUEt9IDvlDiyJNcf8=";
      };
      buildInputs = with pkgs; [ llvm lldb python37 autoPatchelfHook ];
    })
  ]);

  vscode-with-extensions =
    pkgs.vscode-with-extensions.override { vscodeExtensions = extensions; };
in { config = { environment.systemPackages = [ vscode-with-extensions ]; }; }
