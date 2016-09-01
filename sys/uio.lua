--
-- p o s i x . s y s . u i o
--
module(..., package.seeall)
local ffi = require('ffi')
local sys_types = require('posix.sys.types')

ffi.cdef([[
	typedef struct iovec {
		void *iov_base;
		size_t iov_len;
	} iovec_t;
	ssize_t readv (int fd, const struct iovec *iovec, int count);
	ssize_t writev (int fd, const struct iovec *iovec, int count);
	ssize_t preadv (int fd, const struct iovec *iovec, int count,
		off_t offset) ;
	ssize_t pwritev (int fd, const struct iovec *iovec, int count,
		off_t offset) ;
]])
