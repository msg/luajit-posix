--
-- p o s i x . s i g n a l
--
local signal = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')

ffi.cdef([[
enum {
	SIG_ERR		= -1,
	SIG_DFL		= 0,
	SIG_IGN		= 1,

	SIGINT		= 2,
	SIGILL		= 4,
	SIGABRT		= 6,
	SIGFPE		= 8,
	SIGSEGV		= 11,
	SIGTERM		= 15,

	SIGHUP		= 1,
	SIGQUIT		= 3,
	SIGTRAP		= 5,
	SIGKILL		= 9,
	SIGBUS		= 10,
	SIGSYS		= 12,
	SIGPIPE		= 13,
	SIGALRM		= 14,

	SIGURG		= 16,
	SIGSTOP		= 17,
	SIGTSTP		= 18,
	SIGCONT		= 19,
	SIGCHLD		= 20,
	SIGTTIN		= 21,
	SIGTTOU		= 22,
	SIGPOLL		= 23,
	SIGXCPU		= 24,
	SIGXFSZ		= 25,
	SIGVTALRM	= 26,
	SIGPROF		= 27,
	SIGUSR1		= 30,
	SIGUSR2		= 31,

	SIGWINCH	= 28,

	SIGRTMIN	= 32,
	SIGRTMAX	= 64,
};

typedef int sig_atomic_t;

typedef struct
{
  unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
} sigset_t;

union sigval
{
  int sival_int;
  void *sival_ptr;
};

typedef union sigval sigval_t;
typedef struct {
	int si_signo;
	int si_errno;
	int si_code;
	int __pad0;
	union {
		int _pad[((128 / sizeof (int)) - 4)];
		struct {
			pid_t si_pid;
			uid_t si_uid;
		} _kill;
		struct {
			int si_tid;
			int si_overrun;
			sigval_t si_sigval;
		} _timer;
		struct {
			pid_t si_pid;
			uid_t si_uid;
			sigval_t si_sigval;
		} _rt;
		struct {
			pid_t si_pid;
			uid_t si_uid;
			int si_status;
			clock_t si_utime;
			clock_t si_stime;
		} _sigchld;
		struct {
			void *si_addr;
			short int si_addr_lsb;
			union {
				struct {
					void *_lower;
					void *_upper;
				} _addr_bnd;

				uint32_t _pkey;
			} _bounds;
		} _sigfault;
		struct {
			long int si_band;
			int si_fd;
		} _sigpoll;
		struct
		{
			void *_call_addr;
			int _syscall;
			unsigned int _arch;
		} _sigsys;

	} _sifields;
} siginfo_t ;

enum {
	SI_ASYNCNL = -60,
	SI_TKILL = -6,
	SI_SIGIO,
	SI_ASYNCIO,
	SI_MESGQ,
	SI_TIMER,
	SI_QUEUE,
	SI_USER,
	SI_KERNEL = 0x80
};

enum {
	ILL_ILLOPC = 1,
	ILL_ILLOPN,
	ILL_ILLADR,
	ILL_ILLTRP,
	ILL_PRVOPC,
	ILL_PRVREG,
	ILL_COPROC,
	ILL_BADSTK
};

enum {
	FPE_INTDIV = 1,
	FPE_INTOVF,
	FPE_FLTDIV,
	FPE_FLTOVF,
	FPE_FLTUND,
	FPE_FLTRES,
	FPE_FLTINV,
	FPE_FLTSUB
};

enum {
	SEGV_MAPERR = 1,
	SEGV_ACCERR
};

enum {
	BUS_ADRALN = 1,
	BUS_ADRERR,
	BUS_OBJERR,
	BUS_MCEERR_AR,
	BUS_MCEERR_AO
};

enum {
	CLD_EXITED = 1,
	CLD_KILLED,
	CLD_DUMPED,
	CLD_TRAPPED,
	CLD_STOPPED,
	CLD_CONTINUED
};

enum {
	POLL_IN = 1,
	POLL_OUT,
	POLL_MSG,
	POLL_ERR,
	POLL_PRI,
	POLL_HUP
};

typedef struct sigevent {
	sigval_t sigev_value;
	int sigev_signo;
	int sigev_notify;
	union {
		int _pad[((64 / sizeof (int)) - 4)];
		pid_t _tid;
		struct {
			void (*_function) (sigval_t);
			pthread_attr_t *_attribute;
		} _sigev_thread;
	} _sigev_un;
} sigevent_t;

enum {
	SIGEV_SIGNAL = 0,
	SIGEV_NONE,
	SIGEV_THREAD,
	SIGEV_THREAD_ID = 4
};

typedef void (*sighandler_t) (int);

extern sighandler_t sysv_signal (int sig, sighandler_t handler);
extern sighandler_t signal (int sig, sighandler_t handler);
extern int kill (pid_t pid, int sig);
extern int killpg (pid_t pgrp, int sig);
extern int raise (int sig);
extern sighandler_t ssignal (int sig, sighandler_t handler);
extern int gsignal (int sig);
extern void psignal (int sig, const char *s);
extern void psiginfo (const siginfo_t *pinfo, const char *s);
extern int sigblock (int mask);
extern int sigsetmask (int mask);
extern int siggetmask (void);

typedef sighandler_t sig_t;

extern int sigemptyset (sigset_t *set);
extern int sigfillset (sigset_t *set);
extern int sigaddset (sigset_t *set, int signo);
extern int sigdelset (sigset_t *set, int signo);
extern int sigismember (const sigset_t *set, int signo);

struct sigaction {
	union {
		sighandler_t sa_handler;
		void (*sa_sigaction) (int, siginfo_t *, void *);
	}
	sigaction_handler;
	sigset_t sa_mask;
	int sa_flags;
	void (*sa_restorer) (void);
};

extern int sigprocmask (int how, const sigset_t * set, sigset_t *oset);
extern int sigsuspend (const sigset_t *set);
extern int sigaction (int sig, const struct sigaction *act,
        struct sigaction *oact);
extern int sigpending (sigset_t *set);
extern int sigwait (const sigset_t *set, int *sig);
extern int sigwaitinfo (const sigset_t *set, siginfo_t *info);
extern int sigtimedwait (const sigset_t *set, siginfo_t *info,
	const struct timespec *timeout);
extern int sigqueue (pid_t pid, int sig, const union sigval val);

extern const char *const _sys_siglist[ (64 + 1) ];
extern const char *const sys_siglist[ (64 + 1) ];

struct _fpx_sw_bytes {
	uint32_t magic1;
	uint32_t extended_size;
	uint64_t xstate_bv;
	uint32_t xstate_size;
	uint32_t __glibc_reserved1[7];
};

struct _fpreg {
	unsigned short significand[4];
	unsigned short exponent;
};

struct _fpxreg {
	unsigned short significand[4];
	unsigned short exponent;
	unsigned short __glibc_reserved1[3];
};

struct _xmmreg {
	uint32_t element[4];
};

struct _fpstate {

	uint16_t cwd;
	uint16_t swd;
	uint16_t ftw;
	uint16_t fop;
	uint64_t rip;
	uint64_t rdp;
	uint32_t mxcsr;
	uint32_t mxcr_mask;
	struct _fpxreg _st[8];
	struct _xmmreg _xmm[16];
	uint32_t __glibc_reserved1[24];
};

struct sigcontext {
	uint64_t r8;
	uint64_t r9;
	uint64_t r10;
	uint64_t r11;
	uint64_t r12;
	uint64_t r13;
	uint64_t r14;
	uint64_t r15;
	uint64_t rdi;
	uint64_t rsi;
	uint64_t rbp;
	uint64_t rbx;
	uint64_t rdx;
	uint64_t rax;
	uint64_t rcx;
	uint64_t rsp;
	uint64_t rip;
	uint64_t eflags;
	unsigned short cs;
	unsigned short gs;
	unsigned short fs;
	unsigned short __pad0;
	uint64_t err;
	uint64_t trapno;
	uint64_t oldmask;
	uint64_t cr2;
	union {
		struct _fpstate * fpstate;
		uint64_t __fpstate_word;
	};
	uint64_t __reserved1 [8];
};

extern int sigreturn (struct sigcontext *scp);

typedef long unsigned int size_t;

typedef struct {
	void *ss_sp;
	int ss_flags;
	size_t ss_size;
} stack_t;

extern int siginterrupt (int sig, int interrupt);

enum {
	SS_ONSTACK = 1,
	SS_DISABLE
};

extern int sigaltstack (const stack_t *ss, stack_t *oss) ;

struct sigstack {
	void *ss_sp;
	int ss_onstack;
};

extern int sigstack (struct sigstack *ss, struct sigstack *oss);

]])

return setmetatable(signal, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
