--
-- p o s i x . s y s . s o c k e t
--
local socket = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')
		  require('posix.sys.time')

ffi.cdef([[
enum {
	SOCK_STREAM		= 1,
	SOCK_DGRAM		= 2,
	SOCK_RAW		= 3,
	SOCK_SEQPACKET		= 5,

	SOL_SOCKET		= 1,

	SO_ACCEPTCONN   	= 30,
	SO_BROADCAST    	= 6,
	SO_DEBUG        	= 1,
	SO_DONTROUTE    	= 5,
	SO_ERROR        	= 4,
	SO_KEEPALIVE    	= 9,
	SO_LINGER       	= 13,
	SO_OOBINLINE    	= 10,
	SO_RCVBUF       	= 8,
	SO_RCVLOWAT     	= 18,
	SO_RCVTIMEO     	= 20,
	SO_REUSEADDR    	= 2,
	SO_REUSEPORT    	= 15,
	SO_SNDBUF       	= 7,
	SO_SNDLOWAT     	= 19,
	SO_SNDTIMEO     	= 21,
	SO_TYPE         	= 3,

	SOMAXCONN		= 128,

	MSG_OOB			= 0x01,
	MSG_PEEK		= 0x02,
	MSG_DONTROUTE		= 0x04,
	MSG_TRYHARD		= 0x04,
	MSG_CTRUNC		= 0x08,
	MSG_PROXY		= 0x10,
	MSG_DONTWAIT		= 0x40,
	MSG_TRUNC		= 0x20,
	MSG_EOR			= 0x80,
	MSG_WAITALL		= 0x100,
	MSG_FIN			= 0x200,
	MSG_SYN			= 0x400,
	MSG_CONFIRM		= 0x800,
	MSG_RST			= 0x1000,
	MSG_ERRQUEUE		= 0x2000,
	MSG_NOSIGNAL		= 0x4000,
	MSG_MORE		= 0x8000,
	MSG_WAITFORONE		= 0x10000,
	MSG_ZEROCOPY		= 0x4000000,
	MSG_FASTOPEN		= 0x20000000,
	MSG_CMSG_CLOEXEC	= 0x40000000,

	SHUT_RD			= 0,
	SHUT_WR			= 1,
	SHUT_RDWR		= 2,

	AF_UNSPEC		= 0,
	AF_UNIX			= 1,
	AF_INET			= 2,
	AF_INET6		= 10,
	AF_NETLINK		= 16,
	AF_PACKET		= 17,

	SCM_RIGHTS		= 0x01,
};
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

function socket.CMSG_DATA(cmsg) return cmsg.__cmsg_data end
socket.CMSG_NXTHDR = C.__cmsg_nxthdr
function socket.CMSG_FIRSTHDR(mhdr)
	if mhdr.msg_controllen >= ffi.sizeof('struct cmsghdr') then
		return ffi.cast('struct cmsghdr *', mhdr.msg_control)
	else
		return ffi.cast('struct cmsghdr *', nil)
	end
end

return setmetatable(socket, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
