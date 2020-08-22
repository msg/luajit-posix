--
-- p o s i x . n e t i n e t . i n
--
local netinet = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')
require('posix.sys.socket')

ffi.cdef([[
enum {
	INADDR_ANY		= 0x00000000,
	INADDR_BROADCAST	= 0xffffffff,
	INADDR_LOOPBACK		= 0x7f000001,
	INADDR_NONE		= 0xffffffff,

	IPPROTO_IP		= 0,
	IPPROTO_ICMP		= 1,
	IPPROTO_IGMP		= 2,
	IPPROTO_IPIP		= 4,
	IPPROTO_TCP		= 6,
	IPPROTO_EGP		= 8,
	IPPROTO_PUP		= 12,
	IPPROTO_UDP		= 17,
	IPPROTO_IDP		= 22,
	IPPROTO_TP		= 29,
	IPPROTO_DCCP		= 33,
	IPPROTO_IPV6		= 41,
	IPPROTO_RSVP		= 46,
	IPPROTO_GRE		= 47,
	IPPROTO_ESP		= 50,
	IPPROTO_AH		= 51,
	IPPROTO_MTP		= 92,
	IPPROTO_BEETPH		= 94,
	IPPROTO_ENCAP		= 98,
	IPPROTO_PIM		= 103,
	IPPROTO_COMP		= 108,
	IPPROTO_SCTP		= 132,
	IPPROTO_UDPLITE		= 136,
	IPPROTO_MPLS		= 137,
	IPPROTO_RAW		= 255,
	IPPROTO_MAX		= 256,

	IPPROTO_HOPOPTS		= 0,
	IPPROTO_ROUTING		= 43,
	IPPROTO_FRAGMENT	= 44,
	IPPROTO_ICMPV6		= 58,
	IPPROTO_NONE		= 59,
	IPPROTO_DSTOPTS		= 60,
	IPPROTO_MH		= 135,

	IP_OPTIONS		= 4,
	IP_HDRINCL		= 3,
	IP_TOS			= 1,
	IP_TTL			= 2,
	IP_RECVOPTS		= 6,

	IP_RETOPTS			= 7,
	IP_RECVRETOPTS			= 7,

	MCAST_JOIN_GROUP		= 42,
	MCAST_BLOCK_SOURCE		= 43,
	MCAST_UNBLOCK_SOURCE		= 44,
	MCAST_LEAVE_GROUP		= 45,
	MCAST_JOIN_SOURCE_GROUP		= 46,
	MCAST_LEAVE_SOURCE_GROUP	= 47,
	MCAST_MSFILTER			= 48,

	MCAST_EXCLUDE			= 0,
	MCAST_INCLUDE			= 1,

	IP_ROUTER_ALERT			= 5,
	IP_PKTINFO			= 8,
	IP_PKTOPTIONS			= 9,
	IP_PMTUDISC			= 10,
	IP_MTU_DISCOVER			= 10,
	IP_RECVERR			= 11,
	IP_RECVTTL			= 12,
	IP_RECVTOS			= 13,
	IP_MTU				= 14,
	IP_FREEBIND			= 15,
	IP_IPSEC_POLICY			= 16,
	IP_XFRM_POLICY			= 17,
	IP_PASSSEC			= 18,
	IP_TRANSPARENT			= 19,

	IP_ORIGDSTADDR			= 20,
	IP_RECVORIGDSTADDR		= 20,

	IP_MINTTL			= 21,
	IP_NODEFRAG			= 22,
	IP_CHECKSUM			= 23,
	IP_BIND_ADDRESS_NO_PORT		= 24,
	IP_RECVFRAGSIZE			= 25,

	IP_PMTUDISC_DONT		= 0,
	IP_PMTUDISC_WANT		= 1,
	IP_PMTUDISC_DO			= 2,
	IP_PMTUDISC_PROBE		= 3,

	IP_PMTUDISC_INTERFACE		= 4,

	IP_PMTUDISC_OMIT		= 5,

	IP_MULTICAST_TTL		= 33,
	IP_MULTICAST_LOOP		= 34,
	IP_ADD_MEMBERSHIP		= 35,
	IP_DROP_MEMBERSHIP		= 36,
	IP_UNBLOCK_SOURCE		= 37,
	IP_BLOCK_SOURCE			= 38,
	IP_ADD_SOURCE_MEMBERSHIP	= 39,
	IP_DROP_SOURCE_MEMBERSHIP	= 40,
	IP_MSFILTER			= 41,
	IP_MULTICAST_ALL		= 49,
	IP_UNICAST_IF			= 50,

	SOL_IP				= 0,

	IP_DEFAULT_MULTICAST_TTL	= 1,
	IP_DEFAULT_MULTICAST_LOOP	= 1,
	IP_MAX_MEMBERSHIPS		= 20,
};
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

struct ip_mreq {
	struct in_addr imr_multiaddr;
	struct in_addr imr_interface;
};
struct ip_mreq_source {
	struct in_addr imr_multiaddr;
	struct in_addr imr_interface;
	struct in_addr imr_sourceaddr;
};
struct ip_opts {
	struct in_addr ip_dst;
	char ip_opts[40];
};
struct ip_mreqn {
	struct in_addr imr_multiaddr;
	struct in_addr imr_address;
	int imr_ifindex;
};
struct in_pktinfo {
	int ipi_ifindex;
	struct in_addr ipi_spec_dst;
	struct in_addr ipi_addr;
};
]])

return setmetatable(netinet, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
