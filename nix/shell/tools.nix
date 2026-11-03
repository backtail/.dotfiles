{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    jq
    libqalculate
    fzf
    tldr
    bat
    tre-command
    usbutils
    shellify
    nix-search
    mdcat
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
