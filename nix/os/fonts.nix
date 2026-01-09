{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
  ];

  environment.systemPackages = [
    pkgs.nerd-font-patcher
  ];
}
