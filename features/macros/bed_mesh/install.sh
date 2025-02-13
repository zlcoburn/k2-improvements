#!/bin/ash

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

test -d ~/printer_data/config/custom || mkdir -p ~/printer_data/config/custom

ln -sf ${SCRIPT_DIR}/bed_mesh.cfg \
    ~/printer_data/config/custom/bed_mesh.cfg
python ${SCRIPT_DIR}/../../../scripts/ensure_included.py \
    ~/printer_data/config/custom/main.cfg bed_mesh.cfg

/etc/init.d/klipper restart
