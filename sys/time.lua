module(..., package.seeall)
local ffi = require('ffi')
local sys_types = require('posix.sys.types')

ffi.cdef([[
struct timeval {
	time_t tv_sec;
	suseconds_t tv_usec;
};
struct itimerval {
	struct timeval it_interval;
	struct timeval it_value;
};
typedef long int __fd_mask;
typedef struct {
	__fd_mask __fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];
} fd_set;
int getitimer (int __which, struct itimerval *__value);
int gettimeofday (struct timeval *____tv, void *__tz);
int setitimer (int __which, const struct itimerval *____new,
        struct itimerval *____old);
int select (int __nfds, fd_set *____readfds,
     fd_set *____writefds,
     fd_set *____exceptfds,
     struct timeval *____timeout);
int utimes (const char *__file, const struct timeval __tvp[2]);
]])
ITIMER_REAL	= 0
ITIMER_VIRTUAL	= 1
ITIMER_PROF	= 2
