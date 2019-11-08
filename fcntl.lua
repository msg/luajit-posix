--
-- p o s i x . f c n t l
--
local fcntl = { }

local ffi	= require('ffi')

require('posix.sys.types')

ffi.cdef([[
	struct flock {
		short int l_type;
		short int l_whence;
		off_t l_start;
		off_t l_len;
		pid_t l_pid;
	};
	int creat (const char *file, mode_t mode);
	int fcntl (int fd, int cmd, ...);
	int open (const char *file, int oflag, ...);
	int openat (int fd, const char *file, int oflag, ...);
	int posix_fadvise (int fd, off_t offset, off_t len, int advise);
	int posix_fallocate (int fd, off_t offset, off_t len);
]])

fcntl.F_DUPFD		= 0
fcntl.F_DUPFD_CLOEXEC	= 1030
fcntl.F_GETFD		= 1
fcntl.F_SETFD		= 2
fcntl.F_GETFL		= 3
fcntl.F_SETFL		= 4
fcntl.F_GETLK		= 5
fcntl.F_SETLK		= 6
fcntl.F_SETLKW		= 7
fcntl.F_SETOWN		= 8
fcntl.F_GETOWN		= 9

fcntl.FD_CLOEXEC	= 1

fcntl.F_RDLCK		= 0
fcntl.F_UNLCK		= 2
fcntl.F_WRLCK		= 1

fcntl.O_CREAT		= 0x40		-- 0100
fcntl.O_EXCL		= 0x80		-- 0200
fcntl.O_NOCTTY		= 0x100		-- 0400
fcntl.O_TRUNC		= 0x200		-- 01000
fcntl.O_DIRECT		= 0x10000	-- 040000
fcntl.O_NOFOLLOW	= 0x20000	-- 0400000
fcntl.O_CLOEXEC		= 0x80000	-- 02000000

fcntl.O_APPEND		= 0x400		-- 02000
fcntl.O_NONBLOCK	= 0x800		-- 04000
fcntl.O_DSYNC		= 0x1000	-- 010000
fcntl.O_NDELAY		= fcntl.O_NONBLOCK
fcntl.O_SYNC		= 0x101000	-- 04010000

fcntl.O_ACCMODE		= 03

fcntl.O_RDONLY		= 00
fcntl.O_WRONLY		= 01
fcntl.O_RDWR		= 02
fcntl.O_FSYNC		= fcntl.O_SYNC
fcntl.F_ASYNC		= 0x2000	-- 020000

fcntl.POSIX_FADV_NORMAL		= 0
fcntl.POSIX_FADV_RANDOM		= 1
fcntl.POSIX_FADV_SEQUENTIAL	= 2
fcntl.POSIX_FADV_WILLNEED	= 3
fcntl.POSIX_FADV_DONTNEED	= 4
fcntl.POSIX_FADV_NOREUSE	= 5

return fcntl
