--
-- p o s i x . n e t i n e t . i n
--
local netinet = { }

local ffi	= require('ffi')

require('posix.sys.types')
require('posix.sys.socket')

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

netinet.INADDR_ANY		= 0x00000000
netinet.INADDR_BROADCAST	= 0xffffffff
netinet.INADDR_LOOPBACK		= 0x7f000001
netinet.INADDR_NONE		= 0xffffffff

netinet.IPPROTO_IP		= 0
netinet.IPPROTO_ICMP		= 1
netinet.IPPROTO_IGMP		= 2
netinet.IPPROTO_IPIP		= 4
netinet.IPPROTO_TCP		= 6
netinet.IPPROTO_EGP		= 8
netinet.IPPROTO_PUP		= 12
netinet.IPPROTO_UDP		= 17
netinet.IPPROTO_IDP		= 22
netinet.IPPROTO_TP		= 29
netinet.IPPROTO_DCCP		= 33
netinet.IPPROTO_IPV6		= 41
netinet.IPPROTO_RSVP		= 46
netinet.IPPROTO_GRE		= 47
netinet.IPPROTO_ESP		= 50
netinet.IPPROTO_AH		= 51
netinet.IPPROTO_MTP		= 92
netinet.IPPROTO_BEETPH		= 94
netinet.IPPROTO_ENCAP		= 98
netinet.IPPROTO_PIM		= 103
netinet.IPPROTO_COMP		= 108
netinet.IPPROTO_SCTP		= 132
netinet.IPPROTO_UDPLITE		= 136
netinet.IPPROTO_MPLS		= 137
netinet.IPPROTO_RAW		= 255
netinet.IPPROTO_MAX		= 256

netinet.IPPROTO_HOPOPTS		= 0
netinet.IPPROTO_ROUTING		= 43
netinet.IPPROTO_FRAGMENT	= 44
netinet.IPPROTO_ICMPV6		= 58
netinet.IPPROTO_NONE		= 59
netinet.IPPROTO_DSTOPTS		= 60
netinet.IPPROTO_MH		= 135

netinet.IP_OPTIONS		= 4
netinet.IP_HDRINCL		= 3
netinet.IP_TOS			= 1
netinet.IP_TTL			= 2
netinet.IP_RECVOPTS		= 6

netinet.IP_RECVRETOPTS			= netinet.IP_RETOPTS
netinet.IP_RETOPTS			= 7
netinet.IP_MULTICAST_IF			= 32
netinet.IP_MULTICAST_TTL		= 33
netinet.IP_MULTICAST_LOOP		= 34
netinet.IP_ADD_MEMBERSHIP		= 35
netinet.IP_DROP_MEMBERSHIP		= 36
netinet.IP_UNBLOCK_SOURCE		= 37
netinet.IP_BLOCK_SOURCE			= 38
netinet.IP_ADD_SOURCE_MEMBERSHIP	= 39
netinet.IP_DROP_SOURCE_MEMBERSHIP	= 40
netinet.IP_MSFILTER			= 41
netinet.MCAST_JOIN_GROUP		= 42
netinet.MCAST_BLOCK_SOURCE		= 43
netinet.MCAST_UNBLOCK_SOURCE		= 44
netinet.MCAST_LEAVE_GROUP		= 45
netinet.MCAST_JOIN_SOURCE_GROUP		= 46
netinet.MCAST_LEAVE_SOURCE_GROUP	= 47
netinet.MCAST_MSFILTER			= 48
netinet.IP_MULTICAST_ALL		= 49
netinet.IP_UNICAST_IF			= 50

netinet.MCAST_EXCLUDE		= 0
netinet.MCAST_INCLUDE		= 1

netinet.IP_ROUTER_ALERT		= 5
netinet.IP_PKTINFO		= 8
netinet.IP_PKTOPTIONS		= 9
netinet.IP_PMTUDISC		= 10
netinet.IP_MTU_DISCOVER		= 10
netinet.IP_RECVERR		= 11
netinet.IP_RECVTTL		= 12
netinet.IP_RECVTOS		= 13
netinet.IP_MTU			= 14
netinet.IP_FREEBIND		= 15
netinet.IP_IPSEC_POLICY		= 16
netinet.IP_XFRM_POLICY		= 17
netinet.IP_PASSSEC		= 18
netinet.IP_TRANSPARENT		= 19
netinet.IP_MULTICAST_ALL	= 49

netinet.IP_ORIGDSTADDR		= 20
netinet.IP_RECVORIGDSTADDR	= netinet.IP_ORIGDSTADDR

netinet.IP_MINTTL			= 21
netinet.IP_NODEFRAG			= 22
netinet.IP_CHECKSUM			= 23
netinet.IP_BIND_ADDRESS_NO_PORT		= 24
netinet.IP_RECVFRAGSIZE			= 25

netinet.IP_PMTUDISC_DONT		= 0
netinet.IP_PMTUDISC_WANT		= 1
netinet.IP_PMTUDISC_DO			= 2
netinet.IP_PMTUDISC_PROBE		= 3

netinet.IP_PMTUDISC_INTERFACE		= 4

netinet.IP_PMTUDISC_OMIT		= 5

netinet.IP_MULTICAST_IF			= 32
netinet.IP_MULTICAST_TTL		= 33
netinet.IP_MULTICAST_LOOP		= 34
netinet.IP_ADD_MEMBERSHIP		= 35
netinet.IP_DROP_MEMBERSHIP		= 36
netinet.IP_UNBLOCK_SOURCE		= 37
netinet.IP_BLOCK_SOURCE			= 38
netinet.IP_ADD_SOURCE_MEMBERSHIP	= 39
netinet.IP_DROP_SOURCE_MEMBERSHIP	= 40
netinet.IP_MSFILTER			= 41
netinet.IP_MULTICAST_ALL		= 49
netinet.IP_UNICAST_IF			= 50

netinet.SOL_IP				= 0

netinet.IP_DEFAULT_MULTICAST_TTL	= 1
netinet.IP_DEFAULT_MULTICAST_LOOP	= 1
netinet.IP_MAX_MEMBERSHIPS		= 20

return netinet
