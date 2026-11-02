{ pkgs, ... }:
{
  imports = [
    ../../os/desktop.nix
    ../../os/sound.nix
    ../../os/apps.nix
    ../../os/printing.nix
    ../../os/matrix.nix
    ../../os/colors.nix
    ../../temp.nix
  ];

  services.tailscale.enable = true;

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;
  programs.browserpass.enable = true;
  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    pinentry-gnome3
    proton-vpn
    tailscale-systray
    vscode-fhs
    wl-clipboard
  ];
}
