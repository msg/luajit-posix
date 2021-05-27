--
-- p o s i x . s y s . s t a t
--
local stat = {}

local ffi	= require('ffi') -- non-local for cache stuff below
local  C	=  ffi.C
local bit	= require('bit')
local  band	=  bit.band

require('posix.sys.types')
require('posix.time')

ffi.cdef[[
enum {
	S_IFMT		= 0170000,

	S_IFDIR		= 0040000,
	S_IFCHR		= 0020000,
	S_IFBLK		= 0060000,
	S_IFREG		= 0100000,
	S_IFIFO		= 0010000,
	S_IFLNK		= 0120000,
	S_IFSOCK	= 0140000,

	S_ISUID 	= 04000,
	S_ISGID 	= 02000,
	S_ISVTX 	= 01000,
	S_IREAD 	= 0400,
	S_IWRITE	= 0200,
	S_IEXEC		= 0100,
};
]]
if ffi.arch == 'x64' then
ffi.cdef([[
struct stat {
	dev_t st_dev;
	ino_t st_ino;
	nlink_t st_nlink;
	mode_t st_mode;
	uid_t st_uid;
	gid_t st_gid;
	uint32_t __pad0;
	dev_t st_rdev;
	off_t st_size;
	blksize_t st_blksize;
	blkcnt_t st_blocks;
	struct timespec st_atim;
	struct timespec st_mtim;
	struct timespec st_ctim;
	uint64_t glibc_reserved[3];
};
]])
elseif ffi.arch == 'arm64' then
ffi.cdef([[
struct stat {
	dev_t st_dev;
	ino_t st_ino;
	mode_t st_mode;
	nlink_t st_nlink;
	uid_t st_uid;
	gid_t st_gid;
	dev_t st_rdev;
	dev_t __pad1;
	off_t st_size;
	blksize_t st_blksize;
	blkcnt_t st_blocks;
	struct timespec st_atim;
	struct timespec st_mtim;
	struct timespec st_ctim;
	uint64_t glibc_reserved[2];
} __attribute__((packed));
]])
end

ffi.cdef([[
// the actual *stat* interfaces
int __fxstat(int ver, int fd, struct stat *st);
int __xstat(int ver, const char *path, struct stat *st);
int __lxstat(int ver, const char *filename, struct stat *st);
int __fxstatat(int ver, int fd, const char *filename,
		struct stat *st, int flag);

int chmod (const char *file, mode_t mode);
int lchmod (const char *file, mode_t mode);
int fchmod (int fd, mode_t mode);
int fchmodat (int fd, const char *file, mode_t mode, int flag);
mode_t umask (mode_t mask);
mode_t getumask (void);
int mkdir (const char *path, mode_t mode);
int mkdirat (int fd, const char *path, mode_t mode);

int __xmknod(int ver, const char *path, mode_t mode, dev_t dev);
int __xmknodat(int ver, int fd, const char *path, mode_t mode, dev_t dev);

int mkfifo (const char *path, mode_t mode);
int mkfifoat (int fd, const char *path, mode_t mode);
int utimensat (int fd, const char *path, const struct timespec times[2],
        int flags);
int futimens (int fd, const struct timespec times[2]);
]])

function stat.S_TYPEISMQ(buf) return buf.st_mode - buf.st_mode end
function stat.S_TYPEISSEM(buf) return buf.st_mode - buf.st_mode end
function stat.S_TYPEISSHM(buf) return buf.st_mode - buf.st_mode end

function stat.S_ISTYPE(mode, mask)
	return band(mode, stat.S_IFMT) == mask
end

function stat.S_ISDIR(mode) return stat.S_ISTYPE(mode, stat.S_IFDIR) end
function stat.S_ISCHR(mode) return stat.S_ISTYPE(mode, stat.S_IFCHR) end
function stat.S_ISBLK(mode) return stat.S_ISTYPE(mode, stat.S_IFBLK) end
function stat.S_ISREG(mode) return stat.S_ISTYPE(mode, stat.S_IFREG) end
function stat.S_ISFIFO(mode) return stat.S_ISTYPE(mode, stat.S_IFIFO) end
function stat.S_ISLNK(mode) return stat.S_ISTYPE(mode, stat.S_IFLNK) end

function stat.fstat(...)
	return ffi.C.__fxstat(0, ...)
end

function stat.stat(...)
	return ffi.C.__xstat(0, ...)
end

function stat.lstat(...)
	return ffi.C.__lxstat(0, ...)
end

function stat.fstatat(...)
	return ffi.C.__fxstatat(0, ...)
end

function stat.mknod(...)
	return ffi.C.__xmknod(0, ...)
end

function stat.mknodat(...)
	return ffi.C.__xmknodat(0, ...)
end

return setmetatable(stat, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
