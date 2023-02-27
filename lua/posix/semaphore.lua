--
-- p o s i x . s e m a p h o r e . l u a
--
local semaphore = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
typedef union {
	char size[32];
	long int align;
} sem_t;

int sem_init (sem_t *sem, int pshared, unsigned int value);
int sem_destroy (sem_t *sem);
sem_t *sem_open (const char *name, int oflag, ...);
int sem_close (sem_t *sem);
int sem_unlink (const char *name);
int sem_wait (sem_t *sem);
int sem_timedwait (sem_t *sem, const struct timespec *abstime);
int sem_clockwait (sem_t *sem, clockid_t clock, const struct timespec *abstime);
int sem_trywait (sem_t *sem);
int sem_post (sem_t *sem);
int sem_getvalue (sem_t *sem, int *sval);

]])

return setmetatable(semaphore, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
