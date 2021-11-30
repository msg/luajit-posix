--
-- l i n u x . s y s . s i g n a l f d
--
local signalfd = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.signal')
		  require('posix.sys.types')

ffi.cdef([[

struct signalfd_siginfo {
	uint32_t	ssi_signo;
	int32_t 	ssi_errno;
	int32_t		ssi_code;
	uint32_t	ssi_pid;
	uint32_t	ssi_uid;
	int32_t		ssi_fd;
	uint32_t	ssi_tid;
	uint32_t	ssi_band;
	uint32_t	ssi_overrun;
	uint32_t	ssi_trapno;
	int32_t		ssi_int;
	uint64_t	ssi_ptr;
	uint64_t	ssi_utime;
	uint64_t	ssi_stime;
	uint64_t	ssi_addr;
	uint16_t	ssi_addr_lsb;
	uint16_t	__pad2;
	int32_t		ssi_syscall;
	uint64_t	ssi_call_addr;
	uint32_t	ssi_arch;
	uint8_t		__pad[28];
};

enum {
	SFD_CLOEXEC	= 02000000,
	SFD_NONBLOCK	= 00040000,
};

int signalfd(int fd, const sigset_t *mask, int flags);
]])

return setmetatable(signalfd, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
