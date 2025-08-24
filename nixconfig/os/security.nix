{ pkgs, ... }:
{
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSSHSupport = true;
  };

  programs.browserpass.enable = true;

  environment.systemPackages = with pkgs; [
    pinentry-gtk2
    gnupg
    pass
    protonvpn-gui
  ];

  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };
}
