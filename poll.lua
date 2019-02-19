--
-- p o s i x . p o l l
--
local poll = { }

local ffi	= require('ffi')

require('posix.sys.types')

ffi.cdef([[
	typedef unsigned long int nfds_t;
	struct pollfd {
		int fd;
		short int events;
		short int revents;
	};
	int poll (struct pollfd *fds, nfds_t nfds, int timeout);
]])

poll.POLLIN	= 0x001
poll.POLLPRI	= 0x002
poll.POLLOUT	= 0x004
poll.POLLRDNORM	= 0x040
poll.POLLRDBAND	= 0x080
poll.POLLWRNORM	= 0x100
poll.POLLWRBAND	= 0x200
poll.POLLERR	= 0x008
poll.POLLHUP	= 0x010
poll.POLLNVAL	= 0x020

return poll
