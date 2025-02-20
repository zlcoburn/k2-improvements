# Cartographer Firmware

## Linux

The linux flash script is provided by JaminCollins and is suitable to run on Debian and Ubuntu OS's, this can be a bootable live usb if necessary.

1. Connect the Cartographer via the supplied USB cable
2. Open terminal and download the script by running the following in a terminal:

    ```bash
    wget https://raw.githubusercontent.com/jamincollins/k2-improvements/features/cartographer/firmware/flash.sh
    ```

3. Run script by entering `bash ./go.sh` in the terminal and hitting enter

The script should automatically do everything and leave you with a flashed Cartographer.

## Windows Install

The Windows installation is a modified version of the above provided by bigadz and can be run on Windows using WSL2 Ubuntu and usbipd-win. This was tested using Ubuntu 20.04 under WSL2 and usbipd-win 4.4.0 however latest version should be fine.

1. Install [Ubuntu WSL2](https://documentation.ubuntu.com/wsl/en/latest/howto/install-ubuntu-wsl2/)
2. Install [usbipd-win msi installer](https://github.com/dorssel/usbipd-win/releases)
3. Connect the Cartographer via the supplied USB cable
4. Open Ubuntu WSL and download the flash script by entering

    ```bash
    wget https://raw.githubusercontent.com/jamincollins/k2-improvements/features/cartographer/firmware/WSLFlash.sh
    ```

5. Run the script by entering `bash ./WSLFlash.sh` in the terminal and hitting enter

The script should automatically do everything and leave you with a flashed Cartographer.
