{ pkgs, ... }:
{
  imports = [
    ../services/immich.nix
    ../services/syncthing.nix
  ];

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-curses;

  environment.systemPackages = [ pkgs.pinentry-curses ];
}
