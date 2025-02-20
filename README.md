# K2 Improvements

## DISCLAIMER

Use at your own risk, I'm not responsible for fires or broken dreams.  But you do get to keep both halves if something breaks.

## REVAMP

This is the working state of a complete revamp of the repository, almost everything will be changed.

## Installers

A unified installation menu is _planned_.  For now each feature can be found under the [features](./features/) directory.  A `README.md` and installation script `install.sh` are provided for each option.

The unified installer will understand inter option dependencies and ensure they are met.

For now, there are two default installations:

* `gimme-the-jamin.sh`
* `no-carto.sh`

They both install the same set of features (those that I use).  The only difference is whether or not the cartographer bits are installed.

You are still welcome to hand pick which features you want to install.

## Bootstrap

1. Enable root access on the K2 Plus by going to Settings, General tab and root. Take note of the password.
1. Download bootstrap (link here) and extract the folder.
1. To install the bootstrap, connect to your K2 Plus's Fluid interface via browser **http://PrinterIP:4408**
1. Upload the extracted bootstrap folder by going to Settings **{...}**, **+**, **Upload Folder**, and selecting the extracted bootstrap folder.
1. SSH to the K2 Plus using any terminal tool (e.g. PuTTy) using the printers ip adress, port 22, user "root" and the password noted in step 1.
1. Once connected, paste into the terminal `sh /mnt/UDISK/printer_data/config/bootstrap/bootstrap.sh` and hit enter

## Donations

Donations are definitely _not required_, they are appreciated.  If you'd like to donate you can do so [here](https://ko-fi.com/jamincollins).

## Features

* [axis_twist_compensation](./features/axis_twist_compensation/README.md)
* [better init](./features/better-init/README.md)
* [better root](./features/better-root/README.md) home directory
* [Cartographer](./features/cartographer/README.md) support
* installs [Entware](https://github.com/Entware/Entware)
* updated [Fluidd](./features/fluidd/README.md)
* updated [Moonraker](./features/moonraker/README.md)
* [Obico](./features/obico/README.md) - _WIP_
* implements [SCREWS_TILT_CALCULATE](https://www.klipper3d.org/Manual_Level.html#adjusting-bed-leveling-screws-using-the-bed-probe)

And a few quality of life improvement macros

* [MESH_IF_NEEDED](./features/macros/bed_mesh/README.md)
* [START_PRINT](./features/macros/start_print/README.md)
* [M191](./features/macros/m191/README.md)

### Bed Leveling

Sadly, many of the K2 beds resemble a taco or valley.  In the [bed_leveling](bed_leveling) folder you will find a python based script and short writeup on how to apply aluminium tape to shim the bed.

## Credits

* [@Guilouz](https://github.com/Guilouz) - standing on the shoulders of giants
* [@stranula](https://github.com/stranula)
* [@juliosueiras](https://github.com/juliosueiras)

* Moonraker - [https://github.com/Arksine/moonraker](https://github.com/Arksine/moonraker)
* Klipper - [https://github.com/Klipper3d/klipper](https://github.com/Klipper3d/klipper)
* Fluidd - [https://github.com/fluidd-core/fluidd](https://github.com/fluidd-core/fluidd)
* Entware - [https://github.com/Entware/Entware](https://github.com/Entware/Entware)
* Obico - [https://www.obico.io/](https://www.obico.io/)

## FAQ

See the [FAQ](./FAQ.md)
