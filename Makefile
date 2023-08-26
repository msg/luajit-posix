
PACKAGE=luajit-posix.yaml

all:
	sed -i -e "s/version.*/version: \"`git describe --long| \
		sed -e 's/-/./g'`\"/" $(PACKAGE)
	nfpm package -f $(PACKAGE) -p archlinux -t .
	nfpm package -f $(PACKAGE) -p apk -t .
	nfpm package -f $(PACKAGE) -p deb -t .
	nfpm package -f $(PACKAGE) -p rpm -t .

clean:
	rm *.rpm *.deb *.apk *.pkg.tar.*
