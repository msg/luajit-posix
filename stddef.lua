--
-- p o s i x . s t d d e f
--
local stddef = { }

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
typedef int wchar_t;
]])

return stddef
