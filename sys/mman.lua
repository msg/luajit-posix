--
-- p o s i x . s y s . m m a n
--
local M = {}

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

M.MAP_FAILED	= ffi.cast('void *', -1)

M.PROT_READ	= 0x1
M.PROT_WRITE	= 0x2
M.PROT_EXEC	= 0x4
M.PROT_NONE	= 0x0

M.MAP_FIXED	= 0x10
M.MAP_SHARED	= 0x01
M.MAP_PRIVATE	= 0x02
M.MAP_ANONYMOUS	= 0x20

M.MCL_CURRENT	= 1
M.MCL_FUTURE	= 2

M.POSIX_MADV_NORMAL	= 0
M.POSIX_MADV_RANDOM	= 1
M.POSIX_MADV_SEQUENTIAL	= 2
M.POSIX_MADV_WILLNEED	= 3
M.POSIX_MADV_DONTNEED	= 4

M.MADV_NORMAL		= 0     -- No further special treatment.
M.MADV_RANDOM		= 1     -- Expect random page references.
M.MADV_SEQUENTIAL	= 2     -- Expect sequential page references.
M.MADV_WILLNEED		= 3     -- Will need these pages.
M.MADV_DONTNEED		= 4     -- Don't need these pages.
M.MADV_FREE		= 8     -- Free pages only if memory pressure.
M.MADV_REMOVE		= 9     -- Remove these pages and resources.
M.MADV_DONTFORK		= 10    -- Do not inherit across fork.
M.MADV_DOFORK		= 11    -- Do inherit across fork.
M.MADV_MERGEABLE	= 12    -- KSM may merge identical pages.
M.MADV_UNMERGEABLE	= 13    -- KSM may not merge identical pages.
M.MADV_HUGEPAGE		= 14    -- Worth backing with hugepages.
M.MADV_NOHUGEPAGE	= 15    -- Not worth backing with hugepages.
M.MADV_DONTDUMP		= 16    -- Explicity exclude from the core dump,
				-- overrides the coredump filter bits.
M.MADV_DODUMP		= 17    -- Clear the MADV_DONTDUMP flag.
M.MADV_WIPEONFORK	= 18    -- Zero memory on fork, child only.
M.MADV_KEEPONFORK	= 19    -- Undo MADV_WIPEONFORK.
M.MADV_HWPOISON		= 100   -- Poison a page for testing.

return M
