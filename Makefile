
lmod = `pkg-config --variable=INSTALL_LMOD luajit`
cmod = `pkg-config --variable=INSTALL_CMOD luajit`

all:

install:
	for file in `cd lua;find . -name '*.lua'`; do \
		/bin/install -v -D -m644 lua/$$file $(PREFIX)$(lmod)/$$file; \
	done

