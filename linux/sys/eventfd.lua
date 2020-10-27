--
-- l i n u x . s y s . e v e v n t f d
--
local eventfd = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
typedef uint64_t eventfd_t;

enum {
	EFD_SEMAPHORE	= 00000001,
	EFD_CLOEXEC	= 02000000,
	EFD_NONBLOCK	= 00004000,
};

int eventfd(unsigned int count, int flags);
int eventfd_read(int fd, eventfd_t *value);
int eventfd_write(int fd, eventfd_t *value);
]])

return setmetatable(eventfd, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
