--
-- p o s i x . s y s . t y p e s
--
local types = { }

local ffi	= require('ffi')
local  C	=  ffi.C

if ffi.arch == 'x64' or ffi.arch == 'arm64' then
ffi.cdef('typedef unsigned long int nlink_t;')
else
ffi.cdef('typedef unsigned int nlink_t;')
end

ffi.cdef([[
typedef long int blksize_t;
typedef long int blkcnt_t;
typedef long int clock_t;
typedef int clockid_t;
typedef unsigned long int dev_t;
typedef unsigned long int fsblkcnt_t;
typedef unsigned long int fsfilcnt_t;
typedef unsigned int gid_t;
typedef unsigned int id_t;
typedef unsigned long int ino_t;
typedef int key_t;
typedef unsigned int mode_t;
typedef long int off_t;
typedef int pid_t;
typedef union pthread_attr_t {
	char __size[56];
	long int __align;
} pthread_attr_t;
typedef union {
	char __size[32];
	long int __align;
} pthread_barrier_t;
typedef union {
	char __size[4];
	int __align;
} pthread_barrierattr_t;
typedef union {
	struct {
		int __lock;
		unsigned int __futex;
		__extension__ unsigned long long int __total_seq;
		__extension__ unsigned long long int __wakeup_seq;
		__extension__ unsigned long long int __woken_seq;
		void *__mutex;
		unsigned int __nwaiters;
		unsigned int __broadcast_seq;
	} __data;
	char __size[48];
	__extension__ long long int __align;
} pthread_cond_t;
typedef union {
	char __size[4];
	int __align;
} pthread_condattr_t;
typedef unsigned int pthread_key_t;
typedef struct pthread_internal_list
{
  struct pthread_internal_list *__prev;
  struct pthread_internal_list *__next;
} __pthread_list_t;
typedef union {
	struct __pthread_mutex_s {
		int __lock;
		unsigned int __count;
		int __owner;
		unsigned int __nusers;
		int __kind;
		short __spins;
		short __elision;
		__pthread_list_t __list;
	} __data;
	char __size[40];
	long int __align;
} pthread_mutex_t;
typedef union {
	char __size[4];
	int __align;
} pthread_mutexattr_t;
typedef int pthread_once_t;
typedef union {
	struct {
		int __lock;
		unsigned int __nr_readers;
		unsigned int __readers_wakeup;
		unsigned int __writer_wakeup;
		unsigned int __nr_readers_queued;
		unsigned int __nr_writers_queued;
		int __writer;
		int __shared;
		signed char __rwelision;
		unsigned char __pad1[7];
		unsigned long int __pad2;
		unsigned int __flags;
	} __data;
	char __size[56];
	long int __align;
} pthread_rwlock_t;
typedef union {
	char __size[8];
	long int __align;
} pthread_rwlockattr_t;
typedef volatile int pthread_spinlock_t;
typedef unsigned long int pthread_t;
typedef long unsigned int size_t;
typedef long int ssize_t;
typedef long int suseconds_t;
typedef long int time_t;
typedef void *timer_t;
typedef unsigned int uid_t;
struct sched_param {
	int sched_priority;
};
]])

return setmetatable(types, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
