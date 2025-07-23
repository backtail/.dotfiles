{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    libqalculate
    fzf
    tldr
    bat
    tre-command
    wl-clipboard
    usbutils
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
