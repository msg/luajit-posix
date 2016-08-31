module(..., package.seeall)
local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
	int printf(const char *format, ...);
	int sprintf(char *s, const char *format, ...);
	int snprintf(char *s, size_t maxlen, const char *format, ...);
]])
