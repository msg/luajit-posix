--
-- p o s i x . f c n t l
--
local fcntl = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
enum {
	F_DUPFD		= 0,
	F_DUPFD_CLOEXEC	= 1030,
	F_GETFD		= 1,
	F_SETFD		= 2,
	F_GETFL		= 3,
	F_SETFL		= 4,
	F_GETLK		= 5,
	F_SETLK		= 6,
	F_SETLKW	= 7,
	F_SETOWN	= 8,
	F_GETOWN	= 9,

	FD_CLOEXEC	= 1,

	F_RDLCK		= 0,
	F_UNLCK		= 2,
	F_WRLCK		= 1,

	O_CREAT		= 0100,
	O_EXCL		= 0200,
	O_NOCTTY	= 0400,
	O_TRUNC		= 01000,
	O_DIRECT	= 040000,
	O_NOFOLLOW	= 0400000,
	O_CLOEXEC	= 02000000,

	O_APPEND	= 02000,
	O_NONBLOCK	= 04000,
	O_NDELAY	= 04000,
	O_DSYNC		= 010000,
	O_SYNC		= 04010000,
	O_FSYNC		= 04010000,

	O_ACCMODE	= 03,

	O_RDONLY	= 00,
	O_WRONLY	= 01,
	O_RDWR		= 02,
	F_ASYNC		= 020000,

	POSIX_FADV_NORMAL	= 0,
	POSIX_FADV_RANDOM	= 1,
	POSIX_FADV_SEQUENTIAL	= 2,
	POSIX_FADV_WILLNEED	= 3,
	POSIX_FADV_DONTNEED	= 4,
	POSIX_FADV_NOREUSE	= 5,
};

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

return setmetatable(fcntl, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
