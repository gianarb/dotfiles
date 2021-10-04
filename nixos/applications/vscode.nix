{ config, pkgs, ... }:
let
  extensions = (with pkgs.vscode-extensions; [
    ms-vsliveshare.vsliveshare
    matklad.rust-analyzer
    vadimcn.vscode-lldb
  ]);
  vscode-with-extensions =
    pkgs.vscode-with-extensions.override { vscodeExtensions = extensions; };
in { environment.systemPackages = with pkgs; [ lldb vscode-with-extensions ]; }
