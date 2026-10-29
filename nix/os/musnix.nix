{
  inputs ? null,
  ...
}:
{
  imports = [
    (
      if inputs == null then
        "${
          builtins.fetchGit {
            url = "https://github.com/musnix/musnix.git";
            ref = "master";
          }
        }/default.nix"
      else
        inputs.musnix.nixosModules.default
    )
  ];

  musnix.enable = true;
}
