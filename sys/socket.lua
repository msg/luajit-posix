--
-- p o s i x . s y s . s o c k e t
--
local socket = { }

local ffi	= require('ffi')

require('posix.sys.types')
require('posix.sys.time')

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

socket.SCM_RIGHTS = 0x01

function socket.CMSG_DATA(cmsg) return cmsg.__cmsg_data end
socket.CMSG_NXTHDR = C.__cmsg_nxthdr
function socket.CMSG_FIRSTHDR(mhdr)
	if mhdr.msg_controllen >= ffi.sizeof('struct cmsghdr') then
		return ffi.cast('struct cmsghdr *', mhdr.msg_control)
	else
		return ffi.cast('struct cmsghdr *', nil)
	end
end

socket.SOCK_STREAM	= 1
socket.SOCK_DGRAM	= 2
socket.SOCK_RAW		= 3
socket.SOCK_SEQPACKET	= 5

socket.SOL_SOCKET	= 1

socket.SO_ACCEPTCONN   	= 30
socket.SO_BROADCAST    	= 6
socket.SO_DEBUG        	= 1
socket.SO_DONTROUTE    	= 5
socket.SO_ERROR        	= 4
socket.SO_KEEPALIVE    	= 9
socket.SO_LINGER       	= 13
socket.SO_OOBINLINE    	= 10
socket.SO_RCVBUF       	= 8
socket.SO_RCVLOWAT     	= 18
socket.SO_RCVTIMEO     	= 20
socket.SO_REUSEADDR    	= 2
socket.SO_REUSEPORT    	= 15
socket.SO_SNDBUF       	= 7
socket.SO_SNDLOWAT     	= 19
socket.SO_SNDTIMEO     	= 21
socket.SO_TYPE         	= 3

socket.SOMAXCONN	= 128

socket.MSG_OOB		= 0x01
socket.MSG_PEEK		= 0x02
socket.MSG_DONTROUTE	= 0x04
socket.MSG_TRYHARD	= socket.MSG_DONTROUTE
socket.MSG_CTRUNC	= 0x08
socket.MSG_PROXY	= 0x10
socket.MSG_DONTWAIT	= 0x40
socket.MSG_TRUNC	= 0x20
socket.MSG_EOR		= 0x80
socket.MSG_WAITALL	= 0x100
socket.MSG_FIN		= 0x200
socket.MSG_SYN		= 0x400
socket.MSG_CONFIRM	= 0x800
socket.MSG_RST		= 0x1000
socket.MSG_ERRQUEUE	= 0x2000
socket.MSG_NOSIGNAL	= 0x4000
socket.MSG_MORE		= 0x8000
socket.MSG_WAITFORONE	= 0x10000
socket.MSG_FASTOPEN	= 0x20000000
socket.MSG_CMSG_CLOEXEC	= 0x40000000

socket.SHUT_RD		= 0
socket.SHUT_WR		= 1
socket.SHUT_RDWR	= 2

socket.AF_UNSPEC	= 0
socket.AF_UNIX		= 1
socket.AF_INET		= 2
socket.AF_INET6		= 10

return socket
