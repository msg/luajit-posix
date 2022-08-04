--
-- l i n u x . s y s . s o c k e t
--
local socket = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.socket')

ffi.cdef([[
struct msghdr {
	void		*msg_name;
	socklen_t	msg_namelen;

	struct iovec	*msg_iov;
	size_t		msg_iovlen;

	void		*msg_control;
	size_t		msg_controllen;

	int32_t		msg_flags;
};

struct mmsghdr {
	struct msghdr	msg_hdr;
	uint32_t	msg_len;
};

int recvmmsg(int sockfd, struct mmsghdr *msgvec, uint32_t vlen,
		int flags, struct timespec *timeout);
int sendmmsg(int sockfd, struct mmsghdr *msgvec, uint32_t vlen,
		int flags);
]])

return setmetatable(socket, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
