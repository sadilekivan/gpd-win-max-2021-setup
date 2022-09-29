# Maintainer: Your Name <sadilekivan@gmail.com>
pkgname=gpd-win-max-2021-setup
pkgver=0.1.0
pkgrel=1
pkgdesc="Provides various configuration files for the GPD win max 2021 laptop"
arch=("x86_64")
url="https://github.com/sadilekivan/gpd-win-max-2021-setup"
license=("MIT")
depends=("xorg-server")
source=()
md5sums=()

package() {
	cd "$srcdir"
	mkdir -p "$pkgdir/etc/X11/xorg.conf.d"
	install "internal-monitor-rotate.conf" "$pkgdir/etc/X11/xorg.conf.d/30-internal-monitor-rotate.conf"
	install "internal-touchscreen-rotate.conf" "$pkgdir/etc/X11/xorg.conf.d/99-internal-touchscreen-rotate.conf"
	mkdir -p "$pkgdir/etc/modprobe.d"
	install "alsa-base.conf" "$pkgdir/etc/modprobe.d/"
	mkdir -p "$pkgdir/etc/udev/hwdb.d"
	install "mute-key.hwdb" "$pkgdir/etc/udev/hwdb.d/90-mute-key.hwdb"
	#mkdir -p "$pkgdir/etc/grub.d"
	#install "$srcdir/gpd-kernel-param" "$pkgdir/etc/grub.d/05_gpd-kernel-param"
	#grub-mkconfig /boot/grub/grub.cfg
}

