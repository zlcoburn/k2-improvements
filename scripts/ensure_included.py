#!/usr/bin/env python3

import os
import sys

target = f"[include {sys.argv[1]}]"

update_needed = False

with open('/mnt/UDISK/printer_data/config/printer.cfg', 'r') as handle:
    contents = handle.readlines()

    for line in contents:
        if line.strip() == target:
            break
        if line.startswith('#*#'):
            update_needed = True
            contents.insert(contents.index(line), target + '\n')
            break

if update_needed:
    with open('/mnt/UDISK/printer_data/config/printer.cfg', 'w') as handle:
        handle.writelines(contents)
