--
-- p o s i x . s y s . s t a t f s
--
local statfs = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')

ffi.cdef([[
	typedef struct { int __val[2]; } __fsid_t;
	typedef unsigned long int __fsblkcnt_t;
	typedef unsigned long int __fsblkcnt64_t;
	typedef unsigned long int __fsfilcnt_t;
	typedef unsigned long int __fsfilcnt64_t;
	typedef long int __fsword_t;

	struct statfs {
		__fsword_t f_type;
		__fsword_t f_bsize;
		__fsblkcnt_t f_blocks;
		__fsblkcnt_t f_bfree;
		__fsblkcnt_t f_bavail;
		__fsfilcnt_t f_files;
		__fsfilcnt_t f_ffree;
		__fsid_t f_fsid;
		__fsword_t f_namelen;
		__fsword_t f_frsize;
		__fsword_t f_flags;
		__fsword_t f_spare[4];
	};

	int statfs (const char *file, struct statfs *buf);
	int fstatfs (int fildes, struct statfs *buf);
]])

return setmetatable(statfs, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
