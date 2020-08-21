--
-- p o s i x . d i r e n t
--
local dirent = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')

ffi.cdef([[
enum {
	DT_UNKNOWN		= 0,
	DT_FIFO			= 1,
	DT_CHR			= 2,
	DT_DIR			= 4,
	DT_BLK			= 6,
	DT_REG			= 8,
	DT_LNK			= 10,
	DT_SOCK			= 12,
	DT_WHT			= 14,
};
struct dirent {
	ino_t			d_ino;
	off_t			d_off;
	unsigned short int	d_reclen;
	unsigned char		d_type;
	char			d_name[0];
};
typedef char DIR; /* just a handle */

int alphasort(const struct dirent **, const struct dirent **);
int closedir(DIR *);
int dirfd(DIR *);
DIR *fdopendir(int);
DIR *opendir(const char *);
struct dirent *readdir(DIR *);
int readdir_r(DIR *, struct dirent *, struct dirent **);
void rewinddir(DIR *);
int scandir(const char *, struct dirent ***,
		int (*)(const struct dirent *),
		int (*)(const struct dirent **),
		const struct dirent **);
void seekdir(DIR *, long);
long telldir(DIR *);
]])

return setmetatable(dirent, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})

