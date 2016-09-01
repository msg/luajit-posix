--
-- p o s i x . f c n t l
--
module(..., package.seeall)

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

F_DUPFD			= 0
F_DUPFD_CLOEXEC		= 1030
F_GETFD			= 1
F_SETFD			= 2
F_GETFL			= 3
F_SETFL			= 4
F_GETLK			= 5
F_SETLK			= 6
F_SETLKW		= 7
F_SETOWN		= 8
F_GETOWN		= 9

FD_CLOEXEC		= 1

F_RDLCK			= 0
F_UNLCK			= 2
F_WRLCK			= 1

O_CLOEXEC		= 0x80000	-- 02000000
O_CREAT			= 0x40		-- 0100
O_DIRECTORY		= 0x10000	-- 0200000
O_EXCL			= 0x80		-- 0200
O_NOCTTY		= 0x100		-- 0400
O_NOFOLLOW		= 0x20000	-- 0400000
O_TRUNC			= 0x200		-- 01000

O_APPEND		= 0x400		-- 02000
O_DSYNC			= 0x1000	-- 010000
O_NONBLOCK		= 0x800		-- 04000
O_NDELAY		= O_NONBLOCK
O_SYNC			= 0x101000	-- 04010000

O_ACCMODE		= 03

O_RDONLY		= 00
O_WRONLY		= 01
O_RDWR			= 02
O_FSYNC			= O_SYNC
F_ASYNC			= 0x2000	-- 020000

