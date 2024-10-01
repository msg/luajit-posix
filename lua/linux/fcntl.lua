--
-- l i n u x . f c n t l
--
local fcntl = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
enum {
	FALLOC_FL_KEEP_SIZE		= 0x01,
	FALLOC_FL_PUNCH_HOLE		= 0x02,
	FALLOC_FL_NO_HIDE_STALE		= 0x04,
	FALLOC_FL_COLLAPSE_RANGE	= 0x08,
	FALLOC_FL_ZERO_RANGE		= 0x10,
	FALLOC_FL_INSERT_RANGE		= 0x20,
	FALLOC_FL_UNSHARE		= 0x40,

	F_SEAL_SEAL			= 0x0001,
	F_SEAL_SHRINK			= 0x0002,
	F_SEAL_GROW			= 0x0004,
	F_SEAL_WRITE			= 0x0008,
	F_SEAL_FUTURE_WRITE		= 0x0010,
	F_SEAL_EXEC			= 0x0020,
};

int fallocate(int fd, int mode, off_t offset, off_t len);

]])

return setmetatable(fcntl, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
