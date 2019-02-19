--
-- p o s i x . s y s . t i m e
--
local time = { }

local ffi = require('ffi')

require('posix.sys.types')

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

time.ITIMER_REAL	= 0
time.ITIMER_VIRTUAL	= 1
time.ITIMER_PROF	= 2

return time
