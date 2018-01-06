--
-- p o s i x . s y s . s t a t
--
module(..., package.seeall)
local ffi = require('ffi')
local bit = require('bit')
local sys_types = require('posix.sys.types')
local band, bor, lshift = bit.band, bit.bor, bit.lshift

ffi.cdef([[
int stat (const char *file, struct stat *buf);
int fstat (int fd, struct stat *buf);
int stat64 (const char *_file, struct stat64 *buf);
int fstat64 (int fd, struct stat64 *buf);
int fstatat (int fd, const char *file, struct stat *buf, int flag);
int fstatat64 (int fd, const char *file, struct stat64 *buf, int flag);
int lstat (const char *file, struct stat *buf);
int lstat64 (const char *file, struct stat64 *buf);
int chmod (const char *file, mode_t mode);
int lchmod (const char *file, mode_t mode);
int fchmod (int fd, mode_t mode);
int fchmodat (int fd, const char *file, mode_t mode, int flag);
mode_t umask (mode_t mask);
mode_t getumask (void);
int mkdir (const char *path, mode_t mode);
int mkdirat (int fd, const char *path, mode_t mode);
int mknod (const char *path, mode_t mode, dev_t dev);
int mknodat (int fd, const char *path, mode_t mode, dev_t dev);
int mkfifo (const char *path, mode_t mode);
int mkfifoat (int fd, const char *path, mode_t mode);
int utimensat (int fd, const char *path, const struct timespec times[2],
        int flags);
int futimens (int fd, const struct timespec times[2]);
]])

local function octal(val)
	local oct = 0
	local bit = 0
	while val > 0 do
		oct = bor(oct, lshift(math.fmod(val, 10), bit))
		bit = bit + 3
		val = math.floor(val / 10)
	end
	return oct
end

S_IFMT = octal(0170000)

S_IFDIR = octal(0040000)
S_IFCHR = octal(0020000)
S_IFBLK = octal(0060000)
S_IFREG = octal(0100000)
S_IFIFO = octal(0010000)
S_IFLNK = octal(0120000)
S_IFSOCK = octal(0140000)

function S_TYPEISMQ(buf) return buf.st_mode - buf.st_mode end
function S_TYPEISSEM(buf) return buf.st_mode - buf.st_mode end
function S_TYPEISSHM(buf) return buf.st_mode - buf.st_mode end

S_ISUID = octal(04000)
S_ISGID = octal(02000)
S_ISVTX = octal(01000)
S_IREAD = octal(0400)
S_IWRITE = octal(0200)
S_IEXEC = octal(0100)

function S_ISTYPE(mode, mask)
	return bit.band(mode, S_IFMT) == mask
end

function S_ISDIR(mode) return S_ISTYPE(mode, S_IFDIR) end
function S_ISCHR(mode) return S_ISTYPE(mode, S_IFCHR) end
function S_ISBLK(mode) return S_ISTYPE(mode, S_IFBLK) end
function S_ISREG(mode) return S_ISTYPE(mode, S_IFREG) end
function S_ISFIFO(mode) return S_ISTYPE(mode, S_IFIFO) end
function S_ISLNK(mode) return S_ISTYPE(mode, S_IFLNK) end

