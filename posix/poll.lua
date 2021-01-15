--
-- p o s i x . p o l l
--
local poll = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')
require('posix.signal')

ffi.cdef([[
enum {
	POLLIN		= 0x001,
	POLLPRI		= 0x002,
	POLLOUT		= 0x004,
	POLLRDNORM	= 0x040,
	POLLRDBAND	= 0x080,
	POLLWRNORM	= 0x100,
	POLLWRBAND	= 0x200,
	POLLERR		= 0x008,
	POLLHUP		= 0x010,
	POLLNVAL	= 0x020,
};
typedef unsigned long int nfds_t;
struct pollfd {
	int fd;
	short int events;
	short int revents;
};
int poll (struct pollfd *fds, nfds_t nfds, int timeout);
int ppoll (struct pollfd *fds, nfds_t nfds,
	struct timespec *timeout, sigset_t *sigmask);
]])

return setmetatable(poll, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
