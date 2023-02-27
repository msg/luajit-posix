
all:
	sed -i -e "s/version.*/version: \"`git describe --long|sed -e 's/-/./g'`\"/" luajit-posix.yaml
	nfpm package -f luajit-posix.yaml -p archlinux -t .
	nfpm package -f luajit-posix.yaml -p apk -t .
	nfpm package -f luajit-posix.yaml -p deb -t .
	nfpm package -f luajit-posix.yaml -p rpm -t .

