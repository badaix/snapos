#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

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
		--raise-volume)
		if grep -qE '^ENV{ppercent}:=\"75%\"' "${TARGET_DIR}/usr/share/alsa/init/default"; then
			echo "Raising alsa default volume to 100%."
			sed -i -e 's/ENV{ppercent}:="75%"/ENV{ppercent}:="100%"/g' "${TARGET_DIR}/usr/share/alsa/init/default"
			sed -i -e 's/ENV{pvolume}:="-20dB"/ENV{pvolume}:="4dB"/g' "${TARGET_DIR}/usr/share/alsa/init/default"
		fi
		;;
	esac

done
