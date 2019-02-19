# Maintainer: msg
pkgname=luajit-posix
pkgver=2019.02.10.r0.864ad9d
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
		install -D -m644 "$i" "$lmod/posix/$i"
	done
}

