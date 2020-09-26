--
-- p o s i x . t i m e
--
local time = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')

ffi.cdef([[
enum {
	CLOCKS_PER_SEC  		= 1000000,
	CLOCK_REALTIME			= 0,
	CLOCK_MONOTONIC			= 1,
	CLOCK_PROCESS_CPUTIME_ID	= 2,
	CLOCK_THREAD_CPUTIME_ID		= 3,
	CLOCK_BOOTTIME			= 7,
	TIMER_ABSTIME			= 1,
};
struct timespec {
	time_t tv_sec;
	long int tv_nsec;
};

struct tm {
	int tm_sec;
	int tm_min;
	int tm_hour;
	int tm_mday;
	int tm_mon;
	int tm_year;
	int tm_wday;
	int tm_yday;
	int tm_isdst;
	long int tm_gmtoff;
	const char *tm_zone;
};

struct itimerspec {
	struct timespec it_interval;
	struct timespec it_value;
};

char *asctime (const struct tm *tp);
char *asctime_r (const struct tm *tp, char *buf);
clock_t clock (void);
int clock_getcpuclockid (pid_t pid, clockid_t *clock_id);
int clock_getres (clockid_t clock_id, struct timespec *res);
int clock_gettime (clockid_t clock_id, struct timespec *tp);
int clock_nanosleep (clockid_t clock_id, int flags,
       const struct timespec *req, struct timespec *rem);
int clock_settime (clockid_t clock_id, const struct timespec *tp);
char *ctime (const time_t *timer);
char *ctime_r (const time_t *timer, char *buf);
double difftime (time_t time1, time_t time0);
struct tm *getdate (const char *);
struct tm *gmtime (const time_t *timer);
struct tm *gmtime_r (const time_t *timer, struct tm *tp);
struct tm *localtime (const time_t *timer);
struct tm *localtime_r (const time_t *timer, struct tm *tp);
time_t mktime (struct tm *tp);
int nanosleep (const struct timespec *requested_time,
        struct timespec *remaining);
size_t strftime (char *s, size_t maxsize,
   const char *format, const struct tm *tp);
char *strptime(const char *, const char *, struct tm *);
time_t time(time_t *);
time_t timegm (struct tm *tp);
time_t timelocal (struct tm *tp);
int timer_create (clockid_t clock_id, struct sigevent *evp,
    timer_t *timerid);
int timer_delete (timer_t timerid);
int timer_getoverrun (timer_t timerid);
int timer_gettime (timer_t timerid, struct itimerspec *value);
int timer_settime (timer_t timerid, int flags,
     const struct itimerspec *value,
     struct itimerspec *ovalue);
void tzset (void);
extern int daylight;
extern long int timezone;
extern char *tzname[2];
]])

return setmetatable(time, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
