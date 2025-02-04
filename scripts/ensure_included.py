#!/usr/bin/env python3

import os
import sys

target = f"[include {sys.argv[1]}]"

update_needed = True

with open('/mnt/UDISK/printer_data/config/printer.cfg', 'r') as handle:
    contents = handle.readlines()

    for line in contents:
        if line.strip() == target:
            update_needed = False
            break
        if line.startswith('#*#'):
            break

if update_needed:
    contents.insert(contents.index(line), target + '\n')
    with open('/mnt/UDISK/printer_data/config/printer.cfg', 'w') as handle:
        handle.writelines(contents)
