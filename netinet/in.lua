--
-- p o s i x . n e t i n e t . i n
--
local M = { }

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

M.INADDR_ANY		= 0x00000000
M.INADDR_BROADCAST	= 0xffffffff
M.INADDR_LOOPBACK	= 0x7f000001
M.INADDR_NONE		= 0xffffffff

M.IPPROTO_IP		= 0
M.IPPROTO_ICMP		= 1
M.IPPROTO_IGMP		= 2
M.IPPROTO_IPIP		= 4
M.IPPROTO_TCP		= 6
M.IPPROTO_EGP		= 8
M.IPPROTO_PUP		= 12
M.IPPROTO_UDP		= 17
M.IPPROTO_IDP		= 22
M.IPPROTO_TP		= 29
M.IPPROTO_DCCP		= 33
M.IPPROTO_IPV6		= 41
M.IPPROTO_RSVP		= 46
M.IPPROTO_GRE		= 47
M.IPPROTO_ESP		= 50
M.IPPROTO_AH		= 51
M.IPPROTO_MTP		= 92
M.IPPROTO_BEETPH	= 94
M.IPPROTO_ENCAP		= 98
M.IPPROTO_PIM		= 103
M.IPPROTO_COMP		= 108
M.IPPROTO_SCTP		= 132
M.IPPROTO_UDPLITE	= 136
M.IPPROTO_MPLS		= 137
M.IPPROTO_RAW		= 255
M.IPPROTO_MAX		= 256

M.IPPROTO_HOPOPTS	= 0
M.IPPROTO_ROUTING	= 43
M.IPPROTO_FRAGMENT	= 44
M.IPPROTO_ICMPV6	= 58
M.IPPROTO_NONE		= 59
M.IPPROTO_DSTOPTS	= 60
M.IPPROTO_MH		= 135

M.IP_OPTIONS		= 4
M.IP_HDRINCL		= 3
M.IP_TOS		= 1
M.IP_TTL		= 2
M.IP_RECVOPTS		= 6

M.IP_RECVRETOPTS	= IP_RETOPTS
M.IP_RETOPTS		= 7
M.IP_MULTICAST_IF	= 32
M.IP_MULTICAST_TTL	= 33
M.IP_MULTICAST_LOOP	= 34
M.IP_ADD_MEMBERSHIP	= 35
M.IP_DROP_MEMBERSHIP	= 36
M.IP_UNBLOCK_SOURCE	= 37
M.IP_BLOCK_SOURCE		= 38
M.IP_ADD_SOURCE_MEMBERSHIP	= 39
M.IP_DROP_SOURCE_MEMBERSHIP	= 40
M.IP_MSFILTER			= 41
M.MCAST_JOIN_GROUP		= 42
M.MCAST_BLOCK_SOURCE		= 43
M.MCAST_UNBLOCK_SOURCE		= 44
M.MCAST_LEAVE_GROUP		= 45
M.MCAST_JOIN_SOURCE_GROUP	= 46
M.MCAST_LEAVE_SOURCE_GROUP	= 47
M.MCAST_MSFILTER		= 48
M.IP_MULTICAST_ALL		= 49
M.IP_UNICAST_IF			= 50

M.MCAST_EXCLUDE		= 0
M.MCAST_INCLUDE		= 1

M.IP_ROUTER_ALERT	= 5
M.IP_PKTINFO		= 8
M.IP_PKTOPTIONS		= 9
M.IP_PMTUDISC		= 10
M.IP_MTU_DISCOVER	= 10
M.IP_RECVERR		= 11
M.IP_RECVTTL		= 12
M.IP_RECVTOS		= 13
M.IP_MTU		= 14
M.IP_FREEBIND		= 15
M.IP_IPSEC_POLICY	= 16
M.IP_XFRM_POLICY	= 17
M.IP_PASSSEC		= 18
M.IP_TRANSPARENT	= 19
M.IP_MULTICAST_ALL	= 49

M.IP_ORIGDSTADDR	= 20
M.IP_RECVORIGDSTADDR	= IP_ORIGDSTADDR

M.IP_MINTTL			= 21
M.IP_NODEFRAG			= 22
M.IP_CHECKSUM			= 23
M.IP_BIND_ADDRESS_NO_PORT	= 24
M.IP_RECVFRAGSIZE		= 25

M.IP_PMTUDISC_DONT		= 0
M.IP_PMTUDISC_WANT		= 1
M.IP_PMTUDISC_DO		= 2
M.IP_PMTUDISC_PROBE		= 3

M.IP_PMTUDISC_INTERFACE		= 4

M.IP_PMTUDISC_OMIT		= 5

M.IP_MULTICAST_IF		= 32
M.IP_MULTICAST_TTL		= 33
M.IP_MULTICAST_LOOP		= 34
M.IP_ADD_MEMBERSHIP		= 35
M.IP_DROP_MEMBERSHIP		= 36
M.IP_UNBLOCK_SOURCE		= 37
M.IP_BLOCK_SOURCE		= 38
M.IP_ADD_SOURCE_MEMBERSHIP	= 39
M.IP_DROP_SOURCE_MEMBERSHIP	= 40
M.IP_MSFILTER			= 41
M.IP_MULTICAST_ALL		= 49
M.IP_UNICAST_IF			= 50

M.SOL_IP			= 0

M.IP_DEFAULT_MULTICAST_TTL	= 1
M.IP_DEFAULT_MULTICAST_LOOP	= 1
M.IP_MAX_MEMBERSHIPS		= 20

return M
