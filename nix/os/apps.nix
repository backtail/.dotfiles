{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty

    # Apps
    thunderbird
    obsidian
    discord
    telegram-desktop

  ];
}
