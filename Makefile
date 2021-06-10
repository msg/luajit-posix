
all:
	echo "run 'make install PREFIX=<dir>'"

install:
	./build_errno.lua $(PREFIX)/posix/errno.lua
