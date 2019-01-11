--
-- p o s i x . s y s . s o c k e t
--
local M = { }

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')
local sys_time	= require('posix.sys.time')

local C = ffi.C

ffi.cdef([[
	typedef struct sockaddr {
		unsigned short sa_family;
		char sa_data[14];
	} sockaddr_t;
	typedef unsigned short int sa_family_t;
	struct sockaddr_storage {
		sa_family_t ss_family;
		unsigned long int ss_align;
		char ss_padding[(128 - (2 * sizeof (unsigned long int)))];
	};
	typedef unsigned int socklen_t;
	typedef struct msghdr {
		void *msg_name;
		socklen_t msg_namelen;
		struct iovec *msg_iov;
		size_t msg_iovlen;
		void *msg_control;
		size_t msg_controllen;
		int msg_flags;
	} msghdr_t;
	typedef struct mmsghdr {
		struct msghdr msg_hdr;
		unsigned int msg_len;
	} mmsghdr_t;
	struct cmsghdr {
		size_t cmsg_len;
		int cmsg_level;
		int cmsg_type;
		unsigned char __cmsg_data [];
	};
	struct linger {
		int l_onoff;
		int l_linger;
	};
	struct cmsghdr *__cmsg_nxthdr (struct msghdr *__mhdr,
				      struct cmsghdr *__cmsg);

	int accept (int fd, struct sockaddr *addr, socklen_t *addrlen);
	int bind (int fd, struct sockaddr *addr, unsigned int addrlen);
	int connect (int fd, struct sockaddr *addr, unsigned int addrlen);
	int getpeername (int fd, struct sockaddr *addr, socklen_t *len);
	int getsockname (int fd, struct sockaddr *addr, socklen_t *len);
	int getsockopt (int socket, int level, int option_name,
		const void *option_value, socklen_t *option_len);
	int listen (int fd, int n);
	ssize_t recv (int fd, void *buf, size_t n, int flags);
	ssize_t recvmsg (int fd, struct msghdr *message, int flags);
	int recvmmsg (int fd, struct mmsghdr *vmessages,
		unsigned int vlen, int flags, struct timespec *tmo);
	ssize_t recvfrom (int fd, void *buf, size_t n,
		int flags, struct sockaddr *addr, socklen_t *addr_len);
	ssize_t send (int fd, const void *buf, size_t n, int flags);
	ssize_t sendmsg (int fd, const struct msghdr *message, int flags);
	int sendmmsg (int fd, struct mmsghdr *vmessages,
		unsigned int vlen, int flags);
	ssize_t sendto (int fd, const void *buf, size_t n,
		int flags, const struct sockaddr * addr, socklen_t addr_len);
	int setsockopt (int socket, int level, int option_name,
		const void *option_value, socklen_t option_len);
	int shutdown (int fd, int how);
	int sockatmark (int fd);
	int socket(int domain, int type, int protocol);
	int socketpair (int domain, int type, int protocol, int fds[2]);
]])

M.SCM_RIGHTS = 0x01

function M.CMSG_DATA(cmsg) return cmsg.__cmsg_data end
M.CMSG_NXTHDR = C.__cmsg_nxthdr
function M.CMSG_FIRSTHDR(mhdr)
	if mhdr.msg_controllen >= ffi.sizeof('struct cmsghdr') then
		return ffi.cast('struct cmsghdr *', mhdr.msg_control)
	else
		return ffi.cast('struct cmsghdr *', nil)
	end
end

M.SOCK_STREAM		= 1
M.SOCK_DGRAM		= 2
M.SOCK_RAW		= 3
M.SOCK_SEQPACKET	= 5

M.SOL_SOCKET		= 1

M.SO_ACCEPTCONN   	= 30
M.SO_BROADCAST    	= 6
M.SO_DEBUG        	= 1
M.SO_DONTROUTE    	= 5
M.SO_ERROR        	= 4
M.SO_KEEPALIVE    	= 9
M.SO_LINGER       	= 13
M.SO_OOBINLINE    	= 10
M.SO_RCVBUF       	= 8
M.SO_RCVLOWAT     	= 18
M.SO_RCVTIMEO     	= 20
M.SO_REUSEADDR    	= 2
M.SO_REUSEPORT    	= 15
M.SO_SNDBUF       	= 7
M.SO_SNDLOWAT     	= 19
M.SO_SNDTIMEO     	= 21
M.SO_TYPE         	= 3

M.SOMAXCONN		= 128

M.MSG_OOB		= 0x01
M.MSG_PEEK		= 0x02
M.MSG_DONTROUTE		= 0x04
M.MSG_TRYHARD		= MSG_DONTROUTE
M.MSG_CTRUNC		= 0x08
M.MSG_PROXY		= 0x10
M.MSG_DONTWAIT		= 0x40
M.MSG_TRUNC		= 0x20
M.MSG_EOR		= 0x80
M.MSG_WAITALL		= 0x100
M.MSG_FIN		= 0x200
M.MSG_SYN		= 0x400
M.MSG_CONFIRM		= 0x800
M.MSG_RST		= 0x1000
M.MSG_ERRQUEUE		= 0x2000
M.MSG_NOSIGNAL		= 0x4000
M.MSG_MORE		= 0x8000
M.MSG_WAITFORONE	= 0x10000
M.MSG_FASTOPEN		= 0x20000000
M.MSG_CMSG_CLOEXEC	= 0x40000000

M.SHUT_RD		= 0
M.SHUT_WR		= 1
M.SHUT_RDWR		= 2

M.AF_UNSPEC		= 0
M.AF_UNIX		= 1
M.AF_INET		= 2
M.AF_INET6		= 10

return M
