--
-- p o s i x . s y s . t y p e s
--
local types = { }

local ffi	= require('ffi')
local  C	=  ffi.C

if ffi.arch == 'x64' then
	if ffi.os == 'OSX' then
		ffi.cdef([[
typedef uint64_t nlink_t;
typedef int32_t dev_t;
		]])
	else
		ffi.cdef([[
typedef uint64_t nlink_t;
typedef uint64_t  dev_t;
typedef int64_t blksize_t;
		]])
	end
else
ffi.cdef([[
typedef uint32_t nlink_t;
typedef uint64_t dev_t;
typedef int32_t blksize_t;
]])
end

ffi.cdef([[
typedef int64_t blkcnt_t;
typedef int64_t clock_t;
typedef int32_t clockid_t;
typedef uint64_t fsblkcnt_t;
typedef uint64_t fsfilcnt_t;
typedef uint32_t gid_t;
typedef uint32_t id_t;
typedef uint64_t ino_t;
typedef int32_t key_t;
typedef uint32_t mode_t;
typedef int64_t off_t;
typedef int64_t off64_t;
typedef int32_t pid_t;
typedef union pthread_attr_t {
	char __size[56];
	int64_t __align;
} pthread_attr_t;
typedef union {
	char __size[32];
	int64_t __align;
} pthread_barrier_t;
typedef union {
	char __size[4];
	int32_t __align;
} pthread_barrierattr_t;
typedef union {
	struct {
		int32_t __lock;
		uint32_t __futex;
		__extension__ int64_t __total_seq;
		__extension__ int64_t __wakeup_seq;
		__extension__ int64_t __woken_seq;
		void *__mutex;
		uint32_t __nwaiters;
		uint32_t __broadcast_seq;
	} __data;
	char __size[48];
	__extension__ int64_t __align;
} pthread_cond_t;
typedef union {
	char __size[4];
	int32_t __align;
} pthread_condattr_t;
typedef uint32_t pthread_key_t;
typedef struct pthread_internal_list
{
  struct pthread_internal_list *__prev;
  struct pthread_internal_list *__next;
} __pthread_list_t;
typedef union {
	struct __pthread_mutex_s {
		int32_t __lock;
		uint32_t __count;
		int32_t __owner;
		uint32_t __nusers;
		int32_t __kind;
		short __spins;
		short __elision;
		__pthread_list_t __list;
	} __data;
	char __size[48];
	int64_t __align;
} pthread_mutex_t;
typedef union {
	char __size[4];
	int32_t __align;
} pthread_mutexattr_t;
typedef int32_t pthread_once_t;
typedef union {
	struct {
		int32_t __lock;
		uint32_t __nr_readers;
		uint32_t __readers_wakeup;
		uint32_t __writer_wakeup;
		uint32_t __nr_readers_queued;
		uint32_t __nr_writers_queued;
		int32_t __writer;
		int32_t __shared;
		signed char __rwelision;
		unsigned char __pad1[7];
		uint64_t __pad2;
		uint32_t __flags;
	} __data;
	char __size[56];
	int64_t __align;
} pthread_rwlock_t;
typedef union {
	char __size[8];
	int64_t __align;
} pthread_rwlockattr_t;
typedef volatile int32_t pthread_spinlock_t;
typedef uint64_t pthread_t;
typedef int64_t ssize_t;
typedef int64_t suseconds_t;
typedef int64_t time_t;
typedef void *timer_t;
typedef uint32_t uid_t;
struct sched_param {
	int32_t sched_priority;
};
]])

return setmetatable(types, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
