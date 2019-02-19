--
-- p o s i x . s y s . s t a t
--
local stat = {}

local ffi		= require('ffi') -- non-local for cache stuff below
local bit		= require('bit')
local bor, lshift	= bit.bor, bit.lshift

require('posix.sys.types')
require('posix.time')

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

function stat.octal(val)
	local oct = 0
	local bit = 0 -- luacheck: ignore bit
	while val > 0 do
		oct = bor(oct, lshift(math.fmod(val, 10), bit))
		bit = bit + 3
		val = math.floor(val / 10)
	end
	return oct
end

stat.S_IFMT = stat.octal(0170000)

stat.S_IFDIR = stat.octal(0040000)
stat.S_IFCHR = stat.octal(0020000)
stat.S_IFBLK = stat.octal(0060000)
stat.S_IFREG = stat.octal(0100000)
stat.S_IFIFO = stat.octal(0010000)
stat.S_IFLNK = stat.octal(0120000)
stat.S_IFSOCK = stat.octal(0140000)

function stat.S_TYPEISMQ(buf) return buf.st_mode - buf.st_mode end
function stat.S_TYPEISSEM(buf) return buf.st_mode - buf.st_mode end
function stat.S_TYPEISSHM(buf) return buf.st_mode - buf.st_mode end

stat.S_ISUID = stat.octal(04000)
stat.S_ISGID = stat.octal(02000)
stat.S_ISVTX = stat.octal(01000)
stat.S_IREAD = stat.octal(0400)
stat.S_IWRITE = stat.octal(0200)
stat.S_IEXEC = stat.octal(0100)

function stat.S_ISTYPE(mode, mask)
	return bit.band(mode, stat.S_IFMT) == mask
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

-- NOTE: should this become a standard part of all ffi modules?
local cache = { }

setmetatable(stat, {
	__index = function(tbl, key) -- luacheck: ignore tbl
		if not cache[key] then
			cache[key] = assert(loadstring('return ffi.C.'..key))()
		end
		return cache[key]
	end,
})

return stat
