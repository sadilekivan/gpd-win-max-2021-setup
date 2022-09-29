# Maintainer: Your Name <sadilekivan@gmail.com>
pkgname=gpd-win-max-2021-setup
pkgver=0.1.0
pkgrel=1
pkgdesc="Provides various configuration files for the GPD win max 2021 laptop"
arch=("x86_64")
url=""
license=("MIT")
depends=("xorg-server")
source=(
	"internal-monitor-rotate.conf"
	"internal-touchscreen-rotate.conf"
	"alsa-base.conf"
	"mute-key.hwdb"
	"gpd-kernel-param"
)
sha512sums=("SKIP" "SKIP" "SKIP" "SKIP" "SKIP")

package() {
	mkdir -p "$pkgdir/etc/X11/xorg.conf.d"
	install "$srcdir/internal-monitor-rotate.conf" "$pkgdir/etc/X11/xorg.conf.d/30-internal-monitor-rotate.conf"
	install "$srcdir/internal-touchscreen-rotate.conf" "$pkgdir/etc/X11/xorg.conf.d/99-internal-touchscreen-rotate.conf"
	mkdir -p "$pkgdir/etc/modprobe.d"
	install "$srcdir/alsa-base.conf" "$pkgdir/etc/modprobe.d/"
	mkdir -p "$pkgdir/etc/udev/hwdb.d"
	install "$srcdir/mute-key.hwdb" "$pkgdir/etc/udev/hwdb.d/90-mute-key.hwdb"
	# Display changes name when another display is plugged in at boot (thus DSI1 and DSI-1)
	mkdir -p "$pkgdir/etc/grub.d"
	install "$srcdir/gpd-kernel-param" "$pkgdir/etc/grub.d/05_gpd-kernel-param"
	#grub-mkconfig /boot/grub/grub.cfg
}

