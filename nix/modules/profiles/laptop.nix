{ ... }:
{
  imports = [
    ../../os/cache-tmpfs.nix
    ../../os/power.nix
  ];

  services.cacheTmpfs.username = "gax";
}
