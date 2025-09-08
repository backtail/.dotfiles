{ pkgs, ... }:
{
  # Create group
  # users.groups.plugdev = { };

  users.users.gax = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Max Genson";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      # "plugdev"
    ];
  };
}
