# K2 Improvements

## DISCLAIMER

use at your own risk, not responsible for fires or broken dreams.  But you do get to keep both halves if something breaks.

## REVAMP

This is the working state of a complete revamp of the repository, almost everything will be changed.

## Installers

A unified installation menu is _in progress_.  For now each feature can be found under the [features](./features/) directory and an installation script `install.sh` is provided for each option.

The unified installer will understand inter option dependencies and ensure they are met.

## Bootstrap

As the [Cartographer](./features/cartographer/README.md) will likely be using the side USB port, I'm now suggesting that users download the bootstrap bundle, extract the archive, and upload the extracted folder through Fluidd by clicking on `{...}`, `+`, `Upload Folder`.
<insert some pictures or more detail here>

```
sh /mnt/UDISK/printer_data/config/bootstrap/bootstrap.sh
```

## Donations

While donations are definitely _not required_, they are appreciated.  I you'd like to donate you can do so [here](https://ko-fi.com/jamincollins).

## Features

* [better root](./features/better-root/README.md) home directory
* installs [Entware](https://github.com/Entware/Entware)
* implements [SCREWS_TILT_CALCULATE](https://www.klipper3d.org/Manual_Level.html#adjusting-bed-leveling-screws-using-the-bed-probe)
* updated versions of
  * Fluidd, with support for the K2 camera
  * [Moonraker](./features/moonraker/README.md)
* several quality of life improvement macros
  * [START_PRINT](./features/macros/start_print/README.md)
  * [M191](./features/macros/m191/README.md)
* [Cartographer](./features/cartographer/README.md) support
* [Obico](./features/obico/README.md)


------------

## START_PRINT

The improved START_PRINT macro adds:

* support for the M191 macro through an optional **CHAMBER_TEMP** parameter
* Z_TILT_ADJUST
* final M190 call to ensure the bed is at desired temperature

To leveraget the M191, you can pass the desired chamber temperature to `START_PRINT` by replacing this line in your slicer's **Start G-code** macro:

```gcode
START_PRINT EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single]
```

with this one:

```gcode
START_PRINT EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single] CHAMBER_TEMP=[overall_chamber_temperature]
```

## M191

This macro can be used in a couple different ways.

Some slicers (perhaps most) have a setting to generate M141 and M191 temperature control commands.  For Creality Print and Orca Slicer this setting is among the filament setttings near the **Chamber temperature** setting.

## Extras

### Bed Leveling

Sadly, many of the K2 beds resemble a taco or valley.  In the [bed_leveling](bed_leveling) folder you will find a python based script and short writeup on how to apply aluminium tape to shim the bed.

## Credits

* [@Guilouz](https://github.com/Guilouz) - standing on the shoulders of giants
* [@stranula](https://github.com/stranula)
* [@juliosueiras](https://github.com/juliosueiras)

* Moonraker - https://github.com/Arksine/moonraker
* Klipper - https://github.com/Klipper3d/klipper
* Fluidd - https://github.com/fluidd-core/fluidd
* Entware - https://github.com/Entware/Entware
* Obico - https://www.obico.io/

## Fluidd / K2 Webcam

The **WebRTC (Creality K2 Plus)** Stream type implemented by [@juliosueiras](https://github.com/juliosueiras)

# Known Issues

## Obico does not have a camera feed

I am actively working on resolving this.  Obico requires a camera service/binary known as `janus`.  I am not aware of a compatible build of `janus` for the K2's operating system.  So, I'm working on building it.

# FAQ

## I've installed the Camera fixes but I still can't setup the webcam in Fluidd

If you tried to setup the webcam before installing the fixes you've got at least one (or more) broken entries. Because these entries are broken, they can't be removed normally, but we have included a script ease their removal.

```
./scripts/delete-camera <name>
```

## What about KAMP/ Adaptive Bed Mesh

There's a gotcha for this.  Since you're only probing the print area, if your bed has say an upward bend of more than a layer or two, moves outside the print area (like say color swaps) may, run into the bed...

So, this is currently on hold until a safe path forward can be determined/found.
