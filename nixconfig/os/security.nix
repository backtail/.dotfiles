{ pkgs, ... }:
{
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # programs.browserpass.enable = true;

  environment.systemPackages = with pkgs; [
    pinentry-curses
    gnupg
    pass
    # protonvpn-gui
  ];

  # programs.ausweisapp = {
    # enable = true;
    # openFirewall = true;
  # };
}
