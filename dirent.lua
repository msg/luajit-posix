--
-- p o s i x . d i r e n t
--
local dirent = { }

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')

ffi.cdef([[
	struct dirent {
		ino_t			d_ino;
		off_t			d_off;
		unsigned short int	d_reclen;
		unsigned char		d_type;
		char			d_name[256];
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

dirent.DT_UNKNOWN	= 0
dirent.DT_FIFO		= 1
dirent.DT_CHR		= 2
dirent.DT_DIR		= 4
dirent.DT_BLK		= 6
dirent.DT_REG		= 8
dirent.DT_LNK		= 10
dirent.DT_SOCK		= 12
dirent.DT_WHT		= 14

return dirent
