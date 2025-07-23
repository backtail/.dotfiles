{ pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="gpio", MODE="0666", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics ST-LINK V1
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="666", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics ST-LINK/V2
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="666", GROUP="plugdev", TAG+="uaccess"

    # STMicroelectronics ST-LINK/V2.1
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="666", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="666", GROUP="plugdev", TAG+="uaccess"

    # Make an RP2040 in BOOTSEL mode writable by all users, so you can `picotool` without `sudo`. 
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666"
    	
    # Pico Probe
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", MODE="0666"

    # Atmel Corp. JTAG ICE mkII
    ATTR{idVendor}=="03eb", ATTRS{idProduct}=="2103", MODE="666", GROUP="plugdev"

    # Atmel Corp. AVRISP mkII
    ATTR{idVendor}=="03eb", ATTRS{idProduct}=="2104", MODE="666", GROUP="plugdev"

    # Atmel Corp. Dragon
    ATTR{idVendor}=="03eb", ATTRS{idProduct}=="2107", MODE="666", GROUP="plugdev"

  '';
}
