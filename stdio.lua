--
-- p o s i x . s t d i o
--
local stdio = { }

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
	int printf(const char *format, ...);
	int sprintf(char *s, const char *format, ...);
	int snprintf(char *s, size_t maxlen, const char *format, ...);
]])

return stdio
