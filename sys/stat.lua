--
-- p o s i x . s y s . s t a t
--
local M = {}

ffi = require('ffi') -- non-local for cache stuff below
local bit = require('bit')
local sys_types = require('posix.sys.types')
local time = require('posix.time')
local band, bor, lshift = bit.band, bit.bor, bit.lshift

ffi.cdef([[
/* __x86_64__ */
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

function M.octal(val)
	local oct = 0
	local bit = 0
	while val > 0 do
		oct = bor(oct, lshift(math.fmod(val, 10), bit))
		bit = bit + 3
		val = math.floor(val / 10)
	end
	return oct
end

M.S_IFMT = M.octal(0170000)

M.S_IFDIR = M.octal(0040000)
M.S_IFCHR = M.octal(0020000)
M.S_IFBLK = M.octal(0060000)
M.S_IFREG = M.octal(0100000)
M.S_IFIFO = M.octal(0010000)
M.S_IFLNK = M.octal(0120000)
M.S_IFSOCK = M.octal(0140000)

function M.S_TYPEISMQ(buf) return buf.st_mode - buf.st_mode end
function M.S_TYPEISSEM(buf) return buf.st_mode - buf.st_mode end
function M.S_TYPEISSHM(buf) return buf.st_mode - buf.st_mode end

M.S_ISUID = M.octal(04000)
M.S_ISGID = M.octal(02000)
M.S_ISVTX = M.octal(01000)
M.S_IREAD = M.octal(0400)
M.S_IWRITE = M.octal(0200)
M.S_IEXEC = M.octal(0100)

function M.S_ISTYPE(mode, mask)
	return bit.band(mode, M.S_IFMT) == mask
end

function M.S_ISDIR(mode) return M.S_ISTYPE(mode, M.S_IFDIR) end
function M.S_ISCHR(mode) return M.S_ISTYPE(mode, M.S_IFCHR) end
function M.S_ISBLK(mode) return M.S_ISTYPE(mode, M.S_IFBLK) end
function M.S_ISREG(mode) return M.S_ISTYPE(mode, M.S_IFREG) end
function M.S_ISFIFO(mode) return M.S_ISTYPE(mode, M.S_IFIFO) end
function M.S_ISLNK(mode) return M.S_ISTYPE(mode, M.S_IFLNK) end

function M.fstat(...)
	return ffi.C.__fxstat(0, ...)
end

function M.stat(...)
	return ffi.C.__xstat(0, ...)
end

function M.lstat(...)
	return ffi.C.__lxstat(0, ...)
end

function M.fstatat(...)
	return ffi.C.__fxstatat(0, ...)
end

function M.mknod(...)
	return ffi.C.__xmknod(0, ...)
end

function M.mknodat(...)
	return ffi.C.__xmknodat(0, ...)
end

-- NOTE: should this become a standard part of all ffi modules?
local cache = { }

setmetatable(M, {
	__index = function(tbl, key)
		if not cache[key] then
			cache[key] = assert(loadstring('return ffi.C.'..key))()
		end
		return cache[key]
	end,
})

return M
