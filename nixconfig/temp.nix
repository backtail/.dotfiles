{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waypipe
    xwayland-satellite
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland,x11";
  };
}
