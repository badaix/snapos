################################################################################
#
# mpd
#
################################################################################

define SNAP_MPD_INSTALL_EXTRA_FILES
	$(INSTALL) -m 0644 -D $(SNAP_MPD_PKGDIR)/mpd.conf $(TARGET_DIR)/etc/mpd.conf
	mkdir -p $(TARGET_DIR)/var/lib/mpd/playlists
	cp -r $(SNAP_MPD_PKGDIR)/playlists/* $(TARGET_DIR)/var/lib/mpd/playlists/
endef

SNAP_MPD_POST_INSTALL_TARGET_HOOKS += SNAP_MPD_INSTALL_EXTRA_FILES

define SNAP_MPD_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(SNAP_MPD_PKGDIR)/S95mpd $(TARGET_DIR)/etc/init.d/S95mpd
endef

$(eval $(generic-package))
