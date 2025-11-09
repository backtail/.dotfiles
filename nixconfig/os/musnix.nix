{ config, pkgs, ... }:

let
  githubModule = builtins.fetchGit {
    url = "https://github.com/musnix/musnix.git";
    ref = "master";
  };
in
{
  imports = [
    "${githubModule}/default.nix"
  ];

  musnix.enable = true;
}
