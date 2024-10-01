--
-- l i n u x . s y s . e v e v n t f d
--
local eventfd = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
enum {
	MFD_CLOEXEC		= 0x01,
	MFD_ALLOW_SEALING	= 0x02,
	MFD_HUGE_TLB		= 0x04,
	MFD_EXEC		= 0x10,
};

int memfd_create(const char *name, unsigned int flags);
]])

return setmetatable(eventfd, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
