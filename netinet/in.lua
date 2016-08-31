module(..., package.seeall)

local ffi	= require('ffi')
local sys_types	= require('posix.sys.types')
local sys_types	= require('posix.sys.socket')

ffi.cdef([[
	typedef uint16_t in_port_t;
	typedef uint32_t in_addr_t;
	struct in_addr {
		uint32_t s_addr;
	};
	typedef struct sockaddr_in {
		unsigned short sin_family;
		uint16_t sin_port;
		struct in_addr sin_addr;
		char sin_zero[8];
	} sockaddr_in_t;
]])

INADDR_ANY		= 0x00000000
INADDR_BROADCAST	= 0xffffffff
INADDR_LOOPBACK		= 0x7f000001
INADDR_NONE		= 0xffffffff

IPPROTO_IP		= 0
IPPROTO_ICMP		= 1
IPPROTO_IGMP		= 2
IPPROTO_TCP		= 6
IPPROTO_UDP		= 17
IPPROTO_SCTP		= 132
IPPROTO_RAW		= 255

