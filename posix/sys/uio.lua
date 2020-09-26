--
-- p o s i x . s y s . u i o
--
local uio = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')

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

return setmetatable(uio, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
