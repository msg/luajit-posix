--
-- p o s i x . s y s . m m a n
--
local mman = {}

local ffi	= require('ffi')

require('posix.sys.types')

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

mman.MAP_FAILED	= ffi.cast('void *', -1)

mman.PROT_READ		= 0x1
mman.PROT_WRITE		= 0x2
mman.PROT_EXEC		= 0x4
mman.PROT_NONE		= 0x0

mman.MAP_FIXED		= 0x10
mman.MAP_SHARED		= 0x01
mman.MAP_PRIVATE	= 0x02
mman.MAP_ANONYMOUS	= 0x20

mman.MCL_CURRENT	= 1
mman.MCL_FUTURE		= 2

mman.POSIX_MADV_NORMAL		= 0
mman.POSIX_MADV_RANDOM		= 1
mman.POSIX_MADV_SEQUENTIAL	= 2
mman.POSIX_MADV_WILLNEED	= 3
mman.POSIX_MADV_DONTNEED	= 4

mman.MADV_NORMAL	= 0     -- No further special treatment.
mman.MADV_RANDOM	= 1     -- Expect random page references.
mman.MADV_SEQUENTIAL	= 2     -- Expect sequential page references.
mman.MADV_WILLNEED	= 3     -- Will need these pages.
mman.MADV_DONTNEED	= 4     -- Don't need these pages.
mman.MADV_FREE		= 8     -- Free pages only if memory pressure.
mman.MADV_REMOVE	= 9     -- Remove these pages and resources.
mman.MADV_DONTFORK	= 10    -- Do not inherit across fork.
mman.MADV_DOFORK	= 11    -- Do inherit across fork.
mman.MADV_MERGEABLE	= 12    -- KSM may merge identical pages.
mman.MADV_UNMERGEABLE	= 13    -- KSM may not merge identical pages.
mman.MADV_HUGEPAGE	= 14    -- Worth backing with hugepages.
mman.MADV_NOHUGEPAGE	= 15    -- Not worth backing with hugepages.
mman.MADV_DONTDUMP	= 16    -- Explicity exclude from the core dump,
				-- overrides the coredump filter bits.
mman.MADV_DODUMP	= 17    -- Clear the MADV_DONTDUMP flag.
mman.MADV_WIPEONFORK	= 18    -- Zero memory on fork, child only.
mman.MADV_KEEPONFORK	= 19    -- Undo MADV_WIPEONFORK.
mman.MADV_HWPOISON	= 100   -- Poison a page for testing.

return mman
