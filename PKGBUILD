# Maintainer: msg
pkgname=luajit-posix
pkgver=2020.10.27.r0.3cafdbe
pkgrel=1
pkgdesc="A ffi posix interface"
arch=('any')
url="http://localhost"
license=('MIT')
groups=()
depends=('luajit')
makedepends=('pkgconf')
provides=("luajit-posix")

pkgver() {
        cd $startdir
	printf "%s" "$(git describe --long | sed 's/\([^-]*-\)g/r\1/;s/-/./g')"
}

package() {
	cd $startdir

	lmod="$pkgdir$(pkg-config --variable=INSTALL_LMOD luajit)"
	for i in $(find posix -type f -name '*.lua'); do
		install -D -m644 "$i" "$lmod/$i"
	done
	for i in $(find linux -type f -name '*.lua'); do
		install -D -m644 "$i" "$lmod/$i"
	done
}

