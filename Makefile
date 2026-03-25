
lmod = $(PREFIX)`PKG_CONFIG_PATH=/usr/lib/pkgconfig pkg-config --variable=INSTALL_LMOD luajit`
cmod = $(PREFIX)`PKG_CONFIG_PATH=/usr/lib/pkgconfig pkg-config --variable=INSTALL_CMOD luajit`

all:
	echo lmod=$(lmod)
	echo cmod=$(cmod)

install:
	for file in `cd lua;find . -name '*.lua'`; do \
		/bin/install -v -D -m644 lua/$$file $(lmod)/$$file; \
	done

