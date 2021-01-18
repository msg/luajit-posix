--
-- p o s i x . s y s . m m a n
--
local mman = {}

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')

ffi.cdef([[
enum {
	MAP_FAILED		= -1,

	PROT_READ		= 0x1,
	PROT_WRITE		= 0x2,
	PROT_EXEC		= 0x4,
	PROT_NONE		= 0x0,

	MAP_FIXED		= 0x10,
	MAP_SHARED		= 0x01,
	MAP_PRIVATE		= 0x02,
	MAP_ANONYMOUS		= 0x20,

	MAP_GROWSDOWN		= 0x00100,
	MAP_DENYWRITE		= 0x00800,
	MAP_EXECUTABLE		= 0x01000,
	MAP_LOCKED		= 0x02000,
	MAP_NORESERVE		= 0x04000,
	MAP_POPULATE		= 0x08000,
	MAP_NONBLOCK		= 0x10000,
	MAP_STACK		= 0x20000,
	MAP_HUGETLB		= 0x40000,
	MAP_SYNC		= 0x80000,

	MCL_CURRENT		= 1,
	MCL_FUTURE		= 2,

	POSIX_MADV_NORMAL	= 0,
	POSIX_MADV_RANDOM	= 1,
	POSIX_MADV_SEQUENTIAL	= 2,
	POSIX_MADV_WILLNEED	= 3,
	POSIX_MADV_DONTNEED	= 4,

	MS_ASYNC		= 1,
	MS_SYNC			= 4,
	MS_INVALIDATE		= 2,

	MADV_NORMAL		= 0,
	MADV_RANDOM		= 1,
	MADV_SEQUENTIAL		= 2,
	MADV_WILLNEED		= 3,
	MADV_DONTNEED		= 4,
	MADV_FREE		= 8,
	MADV_REMOVE		= 9,
	MADV_DONTFORK		= 10,
	MADV_DOFORK		= 11,
	MADV_MERGEABLE		= 12,
	MADV_UNMERGEABLE	= 13,
	MADV_HUGEPAGE		= 14,
	MADV_NOHUGEPAGE		= 15,
	MADV_DONTDUMP		= 16,
	MADV_DODUMP		= 17,
	MADV_WIPEONFORK		= 18,
	MADV_KEEPONFORK		= 19,
	MADV_HWPOISON		= 100,
};
int mlock (const void *addr, size_t len);
int mlockall (int flags);
void *mmap (void *addr, size_t len, int prot,
		int flags, int fd, off_t offset);
int mprotect (void *addr, size_t len, int prot);
int msync (void *addr, size_t len, int flags);
int munlock (const void *addr, size_t len);
int munlockall (void);
int munmap (void *addr, size_t len);
int madvise (void *addr, size_t len, int advice);
int posix_madvise (void *addr, size_t len, int advice);
int mincore (void *start, size_t len, unsigned char *vec);
int shm_open (const char *name, int oflag, mode_t mode);
int shm_unlink (const char *name);
]])

mman.MAP_FAILED	= ffi.cast('void *', -1)

return setmetatable(mman, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
