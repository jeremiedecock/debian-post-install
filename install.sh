#!/bin/bash

# The MIT License
# 
# Copyright (c) 2014,2015 Jérémie DECOCK <jd.jdhp@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

ASK_TO_REBOOT=0

export PI_ROOT_DIR=$(dirname $0)
export PI_SCRIPTS_COMMON_DIR=${PI_ROOT_DIR}/common/scripts
export PI_SCRIPTS_DEBIAN_DIR=${PI_ROOT_DIR}/scripts
export PI_SCRIPTS_PACKAGES_LISTS_DIR=${PI_ROOT_DIR}/packages_lists/debian_latest

# COMMON FUNCTIONS ############################################################

# Ask for confirmation and execute FN_NAME
pi_confirm() {
    FN_NAME="$1"
    FN_MSG="$2"

    echo "${FN_MSG}"
    read -p "(C)ontinue,(s)kip,(q)uit ? " RESP

    case ${RESP} in
        s) return 0
            ;;
        q) pi_quit_fn
            ;;
    esac

    ${FN_NAME}
}

# Global initialization function
pi_init_fn() {
    # TODO: load state variables
    echo ""
}

# Exit function
pi_quit_fn() {
    # TODO: save state variables
    exit 0
}

###############################################################################

# CHECK ID
if [ $(id -u) -ne 0 ]
then
    echo "This script must be run as root.\n"
    exit 1
fi

pi_init_fn

pi_confirm ${PI_SCRIPTS_COMMON_DIR}/setup_l10n.sh "Localization and internationalization (setup keyboard, locale and timezone)"

pi_confirm ${PI_SCRIPTS_COMMON_DIR}/set_hostname.sh "Configure hostname"

pi_confirm ${PI_SCRIPTS_COMMON_DIR}/update_packages.sh "Update packages"

pi_quit_fn
