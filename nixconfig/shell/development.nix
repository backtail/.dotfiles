{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    lazygit
    vscode-fhs
    gh
    nixfmt-rfc-style
    difftastic
  ];
}
