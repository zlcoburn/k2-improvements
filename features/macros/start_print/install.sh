#!/bin/ash

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

ln -sf ${SCRIPT_DIR}/start_print.cfg \
    ~/printer_data/config/custom/start_print.cfg
python ${SCRIPT_DIR}/../../../scripts/ensure_included.py \
    ~/printer_data/config/custom/main.cfg start_print.cfg

/etc/init.d/klipper restart
