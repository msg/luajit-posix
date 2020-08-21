--
-- p o s i x . s y s . p t h r e a d
--
local pthread = {}

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')
require('posix.time')

pthread.lib = ffi.load('pthread')

ffi.cdef([[
enum {
	PTHREAD_CANCEL_ENABLE		= 0,
	PTHREAD_CANCEL_DISABLE		= 1,
	PTHREAD_CANCEL_DEFERRED		= 0,
	PTHREAD_CANCEL_ASYNCHRONOUS	= 1,
	PTHREAD_CANCELED		= -1,
	PTHREAD_CREATE_JOINABLE		= 0,
	PTHREAD_CREATE_DETACHED		= 1,
	PTHREAD_INHERIT_SCHED		= 0,
	PTHREAD_EXPLICIT_SCHED		= 1,
	PTHREAD_PROCESS_PRIVATE		= 0,
	PTHREAD_PROCESS_SHARED		= 1,
};

int pthread_atfork(void function(), void function(), void function());
int pthread_attr_destroy(pthread_attr_t*);
int pthread_attr_getdetachstate(pthread_attr_t*, int*);
int pthread_attr_getschedparam(pthread_attr_t*, struct sched_param*);
int pthread_attr_init(pthread_attr_t*);
int pthread_attr_setdetachstate(pthread_attr_t*, int);
int pthread_attr_setschedparam(pthread_attr_t*, struct sched_param*);
int pthread_cancel(pthread_t);
void pthread_cleanup_push(void function(void*), void*);
void pthread_cleanup_pop(int);
int pthread_cond_broadcast(pthread_cond_t*);
int pthread_cond_destroy(pthread_cond_t*);
int pthread_cond_init(pthread_cond_t*, pthread_condattr_t*);
int pthread_cond_signal(pthread_cond_t*);
int pthread_cond_timedwait(pthread_cond_t*, pthread_mutex_t*, struct timespec*);
int pthread_cond_wait(pthread_cond_t*, pthread_mutex_t*);
int pthread_condattr_destroy(pthread_condattr_t*);
int pthread_condattr_init(pthread_condattr_t*);
int pthread_create(pthread_t*, pthread_attr_t*, void* function(void*), void*);
int pthread_detach(pthread_t);
int pthread_equal(pthread_t, pthread_t);
void pthread_exit(void*);
void* pthread_getspecific(pthread_key_t);
int pthread_join(pthread_t, void**);
int pthread_key_create(pthread_key_t*, void function(void*));
int pthread_key_delete(pthread_key_t);
int pthread_mutex_destroy(pthread_mutex_t*);
int pthread_mutex_init(pthread_mutex_t*, pthread_mutexattr_t*);
int pthread_mutex_lock(pthread_mutex_t*);
int pthread_mutex_trylock(pthread_mutex_t*);
int pthread_mutex_unlock(pthread_mutex_t*);
int pthread_mutexattr_destroy(pthread_mutexattr_t*);
int pthread_mutexattr_init(pthread_mutexattr_t*);
int pthread_once(pthread_once_t*, void function());
int pthread_rwlock_destroy(pthread_rwlock_t*);
int pthread_rwlock_init(pthread_rwlock_t*, pthread_rwlockattr_t*);
int pthread_rwlock_rdlock(pthread_rwlock_t*);
int pthread_rwlock_tryrdlock(pthread_rwlock_t*);
int pthread_rwlock_trywrlock(pthread_rwlock_t*);
int pthread_rwlock_unlock(pthread_rwlock_t*);
int pthread_rwlock_wrlock(pthread_rwlock_t*);
int pthread_rwlockattr_destroy(pthread_rwlockattr_t*);
int pthread_rwlockattr_init(pthread_rwlockattr_t*);
pthread_t pthread_self();
int pthread_setcancelstate(int, int*);
int pthread_setcanceltype(int, int*);
int pthread_setspecific(pthread_key_t, void*);
void pthread_testcancel();
]])

return setmetatable(pthread, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
