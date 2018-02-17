#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

for arg in "$@"
do
	case "${arg}" in
		--add-wlan0)
		if ! grep -qE '^iface wlan0' "${TARGET_DIR}/etc/network/interfaces"; then
			echo "Adding wlan0 to /etc/network/interfaces."
			cat << __EOF__ >> "${TARGET_DIR}/etc/network/interfaces"

auto wlan0
iface wlan0 inet dhcp
        pre-up wpa_supplicant -B -Dwext -iwlan0 -c/etc/wpa_supplicant.conf
        post-down killall -q wpa_supplicant
        wait-delay 15
__EOF__
		fi
		;;
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
		--raise-volume)
		if grep -qE '^ENV{ppercent}:=\"75%\"' "${TARGET_DIR}/usr/share/alsa/init/default"; then
			echo "Raising alsa default volume to 100%."
			sed -i -e 's/ENV{ppercent}:="75%"/ENV{ppercent}:="100%"/g' "${TARGET_DIR}/usr/share/alsa/init/default"
			sed -i -e 's/ENV{pvolume}:="-20dB"/ENV{pvolume}:="4dB"/g' "${TARGET_DIR}/usr/share/alsa/init/default"
		fi
		;;
		--add-pi3-miniuart-bt-overlay)
		if ! grep -qE '^dtoverlay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# fixes rpi3 ttyAMA0 serial console
dtoverlay=pi3-miniuart-bt
__EOF__
		fi
		;;
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		if ! grep -qE '^arm_control=0x200' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable 64bits support
arm_control=0x200
__EOF__
		fi

		# Enable uart console
		if ! grep -qE '^enable_uart=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable rpi3 ttyS0 serial console
enable_uart=1
__EOF__
		fi
		;;
		--gpu_mem_256=*|--gpu_mem_512=*|--gpu_mem_1024=*)
		# Set GPU memory
		gpu_mem="${arg:2}"
		sed -e "/^${gpu_mem%=*}=/s,=.*,=${gpu_mem##*=}," -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		;;
	esac

done

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
