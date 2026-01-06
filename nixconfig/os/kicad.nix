{ pkgs, lib, ... }:

# force X11 execution
let
  kicadWrapped = pkgs.writeShellScriptBin "kicad" ''
    export DISPLAY=:0
    exec ${lib.getExe pkgs.kicad} "$@"
  '';

  # Combine with original to get desktop files
  kicadFull = pkgs.symlinkJoin {
    name = "kicad-with-desktop";
    paths = [
      pkgs.kicad
      kicadWrapped
    ];
    inherit (pkgs.kicad) meta;
  };
in
{
  environment.systemPackages = [ kicadFull ];
}
