#!/bin/sh

set -u
set -e

for arg in "$@"
do
	case "${arg}" in
		--add-wlan0)
		if ! grep -qE '^iface wlan0' "${TARGET_DIR}/etc/network/interfaces"; then
			echo "Adding wlan0 to /etc/network/interfaces."
			cat << __EOF__ >> "${TARGET_DIR}/etc/network/interfaces"

auto wlan0
iface wlan0 inet dhcp
        pre-up wpa_supplicant -B -iwlan0 -c/etc/wpa_supplicant.conf
        post-down killall -q wpa_supplicant
        wait-delay 15
__EOF__
		fi
		;;
		--mount-boot)
		if ! grep -qE '^/dev/mmcblk0p1' "${TARGET_DIR}/etc/fstab"; then
			mkdir -p "${TARGET_DIR}/boot"
			echo "Adding mount point for /boot to /etc/fstab."
			cat << __EOF__ >> "${TARGET_DIR}/etc/fstab"
/dev/mmcblk0p1	/boot		vfat	defaults	0	2
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
