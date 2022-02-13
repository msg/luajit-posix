
local ffi	= require('ffi')

		  require('posix.sys.stat')

ffi.cdef [[
enum {
	FTW_F,
	FTW_D,
	FTW_DNR,
	FTW_NS,
	FTW_SL,
	FTW_DP,
	FTW_SLN
};

enum {
	FTW_PHYS		= 1,
	FTW_MOUNT		= 2,
	FTW_CHDIR		= 4,
	FTW_DEPTH		= 8,
	FTW_ACTIONRETVAL	= 16,
};

enum {
	FTW_CONTINUE		= 0,
	FTW_STOP		= 1,
	FTW_SKIP_SUBTREE	= 2,
	FTW_SKIP_SIBLINGS	= 3,
};

struct FTW {
	int base;
	int level;
};

typedef int (*ftw_func_t) (const char *filename,
		const struct stat *status, int flag);
typedef int (*nftw_func_t) (const char *filename,
		const struct stat *status, int flag, struct FTW *info);
extern int ftw (const char *dir, ftw_func_t func, int descriptors)
	__attribute__ ((__nonnull__ (1, 2))) ;
extern int nftw (const char *dir, nftw_func_t func, int descriptors, int flag)
	__attribute__ ((__nonnull__ (1, 2))) ;
]]

