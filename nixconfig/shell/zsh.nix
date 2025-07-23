{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "theunraveler";
      plugins = [
        "git"
        "fzf"
      ];
    };
  };
}
