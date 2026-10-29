{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    lazygit
    gh
    nixfmt
    difftastic
  ];
}
