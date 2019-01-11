--
-- p o s i x . f c n t l
--
local fcntl = { }

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

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

fcntl.O_CLOEXEC		= 0x80000	-- 02000000
fcntl.O_CREAT		= 0x40		-- 0100
fcntl.O_DIRECTORY	= 0x10000	-- 0200000
fcntl.O_EXCL		= 0x80		-- 0200
fcntl.O_NOCTTY		= 0x100		-- 0400
fcntl.O_NOFOLLOW	= 0x20000	-- 0400000
fcntl.O_TRUNC		= 0x200		-- 01000

fcntl.O_APPEND		= 0x400		-- 02000
fcntl.O_DSYNC		= 0x1000	-- 010000
fcntl.O_NONBLOCK	= 0x800		-- 04000
fcntl.O_NDELAY		= O_NONBLOCK
fcntl.O_SYNC		= 0x101000	-- 04010000

fcntl.O_ACCMODE		= 03

fcntl.O_RDONLY		= 00
fcntl.O_WRONLY		= 01
fcntl.O_RDWR		= 02
fcntl.O_FSYNC		= O_SYNC
fcntl.F_ASYNC		= 0x2000	-- 020000

return fcntl
