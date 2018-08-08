# Maintainer: msg
pkgname=luajit-posix
pkgver=2018.08.08.r0.9d0d4a2
pkgrel=1
pkgdesc="A ffi posix interface"
arch=('x86_64')
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
	for i in $(find . -type f); do
		install -D -m644 "$i" "$lmod/$i"
	done
}

