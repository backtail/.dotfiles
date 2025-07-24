{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.platformio ];
  services.udev.extraRules = ''
# Atmel Corp. JTAG ICE mkII
ATTR{idVendor}=="03eb", ATTRS{idProduct}=="2103", MODE="666", GROUP="plugdev"
# Atmel Corp. AVRISP mkII
ATTR{idVendor}=="03eb", ATTRS{idProduct}=="2104", MODE="666", GROUP="plugdev"
# Atmel Corp. Dragon
ATTR{idVendor}=="03eb", ATTRS{idProduct}=="2107", MODE="666", GROUP="plugdev"
  '';

}
