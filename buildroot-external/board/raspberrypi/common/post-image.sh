#!/bin/bash

set -e

for arg in "$@"
do
	case "${arg}" in
		--add-audio)
		if ! grep -qE '^dtparam=audio=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Adding 'dtparam=audio=on' to config.txt (enables audio)."
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Enable audio (loads snd_bcm2835)
dtparam=audio=on
__EOF__
		fi
		;;
		--speedup-boot)
		if ! grep -qE '^bootcode_delay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Setting boot delays to 0"
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Speed up boot
bootcode_delay=0
boot_delay=0
boot_delay_ms=0
disable_splash=1
__EOF__
		fi
		;;
	esac

done
