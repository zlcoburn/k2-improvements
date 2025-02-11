#!/bin/ash

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

ln -sf ${SCRIPT_DIR}/m191.cfg \
    ~/printer_data/config/custom/m191.cfg
python ${SCRIPT_DIR}/../../../scripts/ensure_included.py \
    ~/printer_data/config/custom/main.cfg m191.cfg

/etc/init.d/klipper restart
