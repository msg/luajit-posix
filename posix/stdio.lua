--
-- p o s i x . s t d i o
--
local stdio = { }

local ffi	= require('ffi')

		  require('posix.sys.types')

ffi.cdef([[
int printf(const char *format, ...);
int sprintf(char *s, const char *format, ...);
int snprintf(char *s, size_t maxlen, const char *format, ...);
int perror(char *s);
]])

return stdio
