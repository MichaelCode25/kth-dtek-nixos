# kth-dtek-nixos
A repository containing devshells, and tools packaged with nix for the KTH "DTEK" course.

## Usage
### USB-Blaster udev rules
Before doing anything else, you will have to ensure that you have the "USB-Blaster" udev rules on your computer. On NixOS, it is as easy as adding `services.udev.packages = [ pkgs.usb-blaster-udev-rules ];` to your config and rebuilding.

On non-NixOS machines, do the following steps:

Step 1: Add and edit the following file to your system (you need root access), here shown using editor nano (but just choose your favourite editor): 
```
sudo nano /etc/udev/rules.d/92-usbblaster.rules
``` 

Step 2: Write the following into the file, and close it:
```
# USB-Blaster
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE="0666"
# USB-Blaster II
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
```

Step 3: Restart your system. Now, try plugging in the USB cable connected to the DTEK-V board into your computer and type:
```
sudo dmesg | tail
```
and you should see the USB being detected.

### Using devshell
The devshell can be entered with: `nix develop "github:MichaelCode25/kth-dtek-nixos"`.

It provides the following programs:
- RARS: `rars`
- Logisim Evolution: `logisim-evolution`
- DTEK-V Board Tools: `dtekv-run`, `dtekv-download`, and `dtekv-upload`
- RISC-V Toolchain: `riscv32-unknown-elf-gcc`, etc
- Standard Toolchain: `gcc`, etc

*This should be everything that you need for the course*
