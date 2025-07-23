{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.stow
    pkgs.gnumake
    pkgs.tree
  ];

}
