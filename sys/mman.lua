module(..., package.seeall)
local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
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

MAP_FAILED	= ffi.cast('void *', -1)

PROT_READ	= 0x1
PROT_WRITE	= 0x2
PROT_EXEC	= 0x4
PROT_NONE	= 0x0

MAP_FIXED	= 0x10
MAP_SHARED	= 0x01
MAP_PRIVATE	= 0x02
MAP_ANONYMOUS	= 0x20

MCL_CURRENT	= 1
MCL_FUTURE	= 2

POSIX_MADV_NORMAL	= 0
POSIX_MADV_RANDOM	= 1
POSIX_MADV_SEQUENTIAL	= 2
POSIX_MADV_WILLNEED	= 3
POSIX_MADV_DONTNEED	= 4
