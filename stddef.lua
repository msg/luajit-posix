--
-- p o s i x . s t d d e f
--
module(..., package.seeall)

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
typedef int wchar_t;
]])

