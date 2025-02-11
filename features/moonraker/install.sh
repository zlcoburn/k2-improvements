#!/bin/ash

set -e

SCRIPT_DIR=$(readlink -f $(dirname ${0}))

cd ${HOME}

export TMPDIR=/mnt/UDISK/tmp
mkdir -p "${TMPDIR}"

# MUST have Entware installed
if [ ! -f /opt/bin/opkg ]; then
    echo "E: you must have entware installed!"
    exit 1
fi

# handle entware being installed in the current login
if [ -f /etc/profile.d/entware.sh ]; then
    echo ${PATH} | grep -q /opt || source /etc/profile.d/entware.sh
fi

if ! type -p git > /dev/null; then
    opkg install git
fi

progress() {
    echo "#### ${1}"
}

get_pip() {
    if "$(fw_printenv --noheader version)" -ge '1.1.2.6'; then
        progress "pip version new enough"
    else
        progress "upgrading pip ..."
        opkg install curl
        URL="https://bootstrap.pypa.io/get-pip.py"
        SCRIPT_NAME=$(basename ${URL})
        curl "${URL}" -o "${SCRIPT_NAME}"
        /opt/bin/python3 "${SCRIPT_NAME}"
        rm -f "${SCRIPT_NAME}"
    fi
}

# recent firmware seems to have new enough pip already
#get_pip

install_virtualenv() {
    progress "Installing virtualenv ..."
    type -p virtualenv > /dev/null || pip install virtualenv

    # update pip to pull pre-built wheels
    if ! grep -qE '^extra-index-url=https://www.piwheels.org/simple$' /etc/pip.conf; then
        echo 'extra-index-url=https://www.piwheels.org/simple' >> /etc/pip.conf
    fi
}

remove_legacy_symlinks() {
    progress "Removing legacy symlinks ..."
    for ENTRY in moonraker moonraker-env; do
        if [ -L ${ENTRY} ]; then
            rm -f ${ENTRY}
        fi
    done
}

fetch_moonraker() {
    progress "Fetching mooonraker ..."
    # clone my mooonraker fork
    if [ -d moonraker/.git ]; then
        git -C moonraker pull
    else
        git clone https://github.com/jamincollins/moonraker.git
    fi
}

create_moonraker_venv() {
    progress "Creating mooonraker venv..."
    # python 3.9.12
    test -d moonraker-env || virtualenv -p /usr/bin/python3 moonraker-env

    ./moonraker-env/bin/pip \
        install \
        --upgrade \
        --find-links=${SCRIPT_DIR}/wheels \
        --requirement moonraker/scripts/moonraker-requirements.txt

    ./moonraker-env/bin/pip \
        install \
        lmdb

    python3 ${SCRIPT_DIR}/../../scripts/fix_venv.py moonraker-env
}

replace_moonraker() {
    # capture existing config
    if [ -f /usr/share/moonraker/moonraker.conf ]; then
        mv /usr/share/moonraker/moonraker.conf \
            /mnt/UDISK/printer_data/config/moonraker.conf
    fi
    progress "Stopping legacy mooonraker ..."
    /etc/init.d/moonraker stop


    progress "Replacing legacy mooonraker with mainline ..."
    # replace existing paths with symlinks
    rm -fr /usr/share/moonraker
    ln -sf ~/moonraker/moonraker /usr/share/moonraker

    rm -fr /usr/share/moonraker-env
    ln -sf ~/moonraker-env /usr/share/moonraker-env

    # update init script location for new config file location
    ln -sf ${SCRIPT_DIR}/moonraker.init /etc/init.d/moonraker

    # remove the deprecated derective
    sed -Ei \
        '/enable_inotify_warnings: False/d' \
        /mnt/UDISK/printer_data/config/moonraker.conf

    # turn on update manager
    if ! grep -q '^\[update_manager\]' /mnt/UDISK/printer_data/config/moonraker.conf; then
        cat >> /mnt/UDISK/printer_data/config/moonraker.conf <<-EOF

[update_manager]
refresh_interval: 168
enable_auto_refresh: True
# no real system updates other than Creality firmwares currently
enable_system_updates: False
EOF
    fi

    progress "Starting mooonraker ..."
    /etc/init.d/moonraker start
}

install_virtualenv
remove_legacy_symlinks
fetch_moonraker
create_moonraker_venv
replace_moonraker
