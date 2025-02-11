#!/bin/ash

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

ln -sf ${SCRIPT_DIR}/bed_mesh.cfg \
    ~/printer_data/config/custom/bed_mesh.cfg
python ${SCRIPT_DIR}/../../../scripts/ensure_included.py \
    ~/printer_data/config/custom/main.cfg bed_mesh.cfg

/etc/init.d/klipper restart
