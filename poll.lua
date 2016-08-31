module(..., package.seeall)

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
	typedef unsigned long int nfds_t;
	struct pollfd {
		int fd;
		short int events;
		short int revents;
	};
	int poll (struct pollfd *fds, nfds_t nfds, int timeout);
]])

POLLIN		= 0x001
POLLPRI		= 0x002
POLLOUT		= 0x004
POLLRDNORM	= 0x040
POLLRDBAND	= 0x080
POLLWRNORM	= 0x100
POLLWRBAND	= 0x200
POLLERR		= 0x008
POLLHUP		= 0x010
POLLNVAL	= 0x020
