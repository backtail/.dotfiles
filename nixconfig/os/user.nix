{ pkgs, ... }:
{
  users.users.gax = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Max Genson";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
    ];
    packages = with pkgs; [ ];
  };
}
