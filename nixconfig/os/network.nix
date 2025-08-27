{ pkgs, ... }:
{
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    tailscale-systray
  ];
}
