
enum {
 RTNL_FAMILY_IPMR = 128,
 RTNL_FAMILY_IP6MR = 129,
 RTNL_FAMILY_MAX = 129,
};

enum {
 RTM_BASE = 16,

 RTM_NEWLINK = 16,
 RTM_DELLINK,
 RTM_GETLINK,
 RTM_SETLINK,

 RTM_NEWADDR = 20,
 RTM_DELADDR,
 RTM_GETADDR,

 RTM_NEWROUTE = 24,
 RTM_DELROUTE,
 RTM_GETROUTE,

 RTM_NEWNEIGH = 28,
 RTM_DELNEIGH,
 RTM_GETNEIGH,

 RTM_NEWRULE = 32,
 RTM_DELRULE,
 RTM_GETRULE,

 RTM_NEWQDISC = 36,
 RTM_DELQDISC,
 RTM_GETQDISC,

 RTM_NEWTCLASS = 40,
 RTM_DELTCLASS,
 RTM_GETTCLASS,

 RTM_NEWTFILTER = 44,
 RTM_DELTFILTER,
 RTM_GETTFILTER,

 RTM_NEWACTION = 48,
 RTM_DELACTION,
 RTM_GETACTION,

 RTM_NEWPREFIX = 52,

 RTM_GETMULTICAST = 58,

 RTM_GETANYCAST = 62,

 RTM_NEWNEIGHTBL = 64,
 RTM_GETNEIGHTBL = 66,
 RTM_SETNEIGHTBL,

 RTM_NEWNDUSEROPT = 68,

 RTM_NEWADDRLABEL = 72,
 RTM_DELADDRLABEL,
 RTM_GETADDRLABEL,

 RTM_GETDCB = 78,
 RTM_SETDCB,

 RTM_NEWNETCONF = 80,
 RTM_DELNETCONF,
 RTM_GETNETCONF = 82,

 RTM_NEWMDB = 84,
 RTM_DELMDB = 85,
 RTM_GETMDB = 86,

 RTM_NEWNSID = 88,
 RTM_DELNSID = 89,
 RTM_GETNSID = 90,

 RTM_NEWSTATS = 92,
 RTM_GETSTATS = 94,
 RTM_SETSTATS,

 RTM_NEWCACHEREPORT = 96,

 RTM_NEWCHAIN = 100,
 RTM_DELCHAIN,
 RTM_GETCHAIN,

 RTM_NEWNEXTHOP = 104,
 RTM_DELNEXTHOP,
 RTM_GETNEXTHOP,

 RTM_NEWLINKPROP = 108,
 RTM_DELLINKPROP,
 RTM_GETLINKPROP,

 RTM_NEWVLAN = 112,
 RTM_DELVLAN,
 RTM_GETVLAN,

 RTM_NEWNEXTHOPBUCKET = 116,
 RTM_DELNEXTHOPBUCKET,
 RTM_GETNEXTHOPBUCKET,

 RTM_NEWTUNNEL = 120,
 RTM_DELTUNNEL,
 RTM_GETTUNNEL,

 __RTM_MAX,
 RTM_MAX = (((__RTM_MAX + 3) & ~3) - 1),
};

enum {
 RTM_NR_MSGTYPES = (RTM_MAX + 1 - RTM_BASE),
 RTM_NR_FAMILIES = (RTM_NR_MSGTYPES >> 2),
};
/*
#define RTM_FAM(cmd) (((cmd) - RTM_BASE) >> 2)
*/

struct rtattr {
 unsigned short rta_len;
 unsigned short rta_type;
};

enum { RTA_ALIGNTO = 4U, };
/*
#define RTA_ALIGN(len) ( ((len)+RTA_ALIGNTO-1) & ~(RTA_ALIGNTO-1) )
#define RTA_OK(rta,len) ((len) >= (int)sizeof(struct rtattr) && \
    (rta)->rta_len >= sizeof(struct rtattr) && \
    (rta)->rta_len <= (len))
#define RTA_NEXT(rta,attrlen) ((attrlen) -= RTA_ALIGN((rta)->rta_len), \
     (struct rtattr*)(((char*)(rta)) + RTA_ALIGN((rta)->rta_len)))
#define RTA_LENGTH(len) (RTA_ALIGN(sizeof(struct rtattr)) + (len))
#define RTA_SPACE(len) RTA_ALIGN(RTA_LENGTH(len))
#define RTA_DATA(rta) ((void*)(((char*)(rta)) + RTA_LENGTH(0)))
#define RTA_PAYLOAD(rta) ((int)((rta)->rta_len) - RTA_LENGTH(0))
*/

struct rtmsg {
 unsigned char rtm_family;
 unsigned char rtm_dst_len;
 unsigned char rtm_src_len;
 unsigned char rtm_tos;

 unsigned char rtm_table;
 unsigned char rtm_protocol;
 unsigned char rtm_scope;
 unsigned char rtm_type;

 unsigned rtm_flags;
};

enum {
 RTN_UNSPEC,
 RTN_UNICAST,
 RTN_LOCAL,
 RTN_BROADCAST,

 RTN_ANYCAST,

 RTN_MULTICAST,
 RTN_BLACKHOLE,
 RTN_UNREACHABLE,
 RTN_PROHIBIT,
 RTN_THROW,
 RTN_NAT,
 RTN_XRESOLVE,
 __RTN_MAX,
 RTN_MAX = (__RTN_MAX - 1),
};

enum {
 RTPROT_UNSPEC = 0,
 RTPROT_REDIRECT = 1,

 RTPROT_KERNEL = 2,
 RTPROT_BOOT = 3,
 RTPROT_STATIC = 4,

 RTPROT_GATED = 8,
 RTPROT_RA = 9,
 RTPROT_MRT = 10,
 RTPROT_ZEBRA = 11,
 RTPROT_BIRD = 12,
 RTPROT_DNROUTED = 13,
 RTPROT_XORP = 14,
 RTPROT_NTK = 15,
 RTPROT_DHCP = 16,
 RTPROT_MROUTED = 17,
 RTPROT_KEEPALIVED = 18,
 RTPROT_BABEL = 42,
 RTPROT_OPENR = 99,
 RTPROT_BGP = 186,
 RTPROT_ISIS = 187,
 RTPROT_OSPF = 188,
 RTPROT_RIP = 189,
 RTPROT_EIGRP = 192,
};

enum rt_scope_t {
 RT_SCOPE_UNIVERSE=0,

 RT_SCOPE_SITE=200,
 RT_SCOPE_LINK=253,
 RT_SCOPE_HOST=254,
 RT_SCOPE_NOWHERE=255
};

enum {
 RTM_F_NOTIFY = 0x100,
 RTM_F_CLONED = 0x200,
 RTM_F_EQUALIZE = 0x400,
 RTM_F_PREFIX = 0x800,
 RTM_F_LOOKUP_TABLE = 0x1000,
 RTM_F_FIB_MATCH = 0x2000,
 RTM_F_OFFLOAD = 0x4000,
 RTM_F_TRAP = 0x8000,
 RTM_F_OFFLOAD_FAILED = 0x20000000,
};

enum rt_class_t {
 RT_TABLE_UNSPEC=0,

 RT_TABLE_COMPAT=252,
 RT_TABLE_DEFAULT=253,
 RT_TABLE_MAIN=254,
 RT_TABLE_LOCAL=255,
 RT_TABLE_MAX=0xFFFFFFFF
};

enum rtattr_type_t {
 RTA_UNSPEC,
 RTA_DST,
 RTA_SRC,
 RTA_IIF,
 RTA_OIF,
 RTA_GATEWAY,
 RTA_PRIORITY,
 RTA_PREFSRC,
 RTA_METRICS,
 RTA_MULTIPATH,
 RTA_PROTOINFO,
 RTA_FLOW,
 RTA_CACHEINFO,
 RTA_SESSION,
 RTA_MP_ALGO,
 RTA_TABLE,
 RTA_MARK,
 RTA_MFC_STATS,
 RTA_VIA,
 RTA_NEWDST,
 RTA_PREF,
 RTA_ENCAP_TYPE,
 RTA_ENCAP,
 RTA_EXPIRES,
 RTA_PAD,
 RTA_UID,
 RTA_TTL_PROPAGATE,
 RTA_IP_PROTO,
 RTA_SPORT,
 RTA_DPORT,
 RTA_NH_ID,
 __RTA_MAX,
 RTA_MAX = (__RTA_MAX - 1),
};

/*
#define RTM_RTA(r) ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
#define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
*/

struct rtnexthop {
 unsigned short rtnh_len;
 unsigned char rtnh_flags;
 unsigned char rtnh_hops;
 int rtnh_ifindex;
};

enum {
 RTNH_F_DEAD = 1,
 RTNH_F_PERVASIVE = 2,
 RTNH_F_ONLINK = 4,
 RTNH_F_OFFLOAD = 8,
 RTNH_F_LINKDOWN = 16,
 RTNH_F_UNRESOLVED = 32,
 RTNH_F_TRAP = 64,

 RTNH_COMPARE_MASK = (RTNH_F_DEAD | RTNH_F_LINKDOWN | \
     RTNH_F_OFFLOAD | RTNH_F_TRAP),
};

enum { RTNH_ALIGNTO = 4, };
/*
#define RTNH_ALIGN(len) ( ((len)+RTNH_ALIGNTO-1) & ~(RTNH_ALIGNTO-1) )
#define RTNH_OK(rtnh,len) ((rtnh)->rtnh_len >= sizeof(struct rtnexthop) && \
      ((int)(rtnh)->rtnh_len) <= (len))
#define RTNH_NEXT(rtnh) ((struct rtnexthop*)(((char*)(rtnh)) + RTNH_ALIGN((rtnh)->rtnh_len)))
#define RTNH_LENGTH(len) (RTNH_ALIGN(sizeof(struct rtnexthop)) + (len))
#define RTNH_SPACE(len) RTNH_ALIGN(RTNH_LENGTH(len))
#define RTNH_DATA(rtnh) ((struct rtattr*)(((char*)(rtnh)) + RTNH_LENGTH(0)))
*/

struct rtvia {
 uint16_t rtvia_family;
 uint8_t rtvia_addr[];
};

struct rta_cacheinfo {
 uint32_t rta_clntref;
 uint32_t rta_lastuse;
 int32_t rta_expires;
 uint32_t rta_error;
 uint32_t rta_used;

 uint32_t rta_id;
 uint32_t rta_ts;
 uint32_t rta_tsage;
};
enum { RTNETLINK_HAVE_PEERINFO = 1, };

enum {
 RTAX_UNSPEC,
 RTAX_LOCK,
 RTAX_MTU,
 RTAX_WINDOW,
 RTAX_RTT,
 RTAX_RTTVAR,
 RTAX_SSTHRESH,
 RTAX_CWND,
 RTAX_ADVMSS,
 RTAX_REORDERING,
 RTAX_HOPLIMIT,
 RTAX_INITCWND,
 RTAX_FEATURES,
 RTAX_RTO_MIN,
 RTAX_INITRWND,
 RTAX_QUICKACK,
 RTAX_CC_ALGO,
 RTAX_FASTOPEN_NO_COOKIE,
 __RTAX_MAX,
 RTAX_MAX = (__RTAX_MAX - 1),
};

enum { 
 RTAX_FEATURE_ECN = (1 << 0),
 RTAX_FEATURE_SACK = (1 << 1),
 RTAX_FEATURE_TIMESTAMP = (1 << 2),
 RTAX_FEATURE_ALLFRAG = (1 << 3),
 RTAX_FEATURE_TCP_USEC_TS = (1 << 4),

 RTAX_FEATURE_MASK = (RTAX_FEATURE_ECN | \
     RTAX_FEATURE_SACK | \
     RTAX_FEATURE_TIMESTAMP | \
     RTAX_FEATURE_ALLFRAG | \
     RTAX_FEATURE_TCP_USEC_TS),
};

struct rta_session {
 uint8_t proto;
 uint8_t pad1;
 uint16_t pad2;

 union {
  struct {
   uint16_t sport;
   uint16_t dport;
  } ports;

  struct {
   uint8_t type;
   uint8_t code;
   uint16_t ident;
  } icmpt;

  uint32_t spi;
 } u;
};

struct rta_mfc_stats {
 uint64_t mfcs_packets;
 uint64_t mfcs_bytes;
 uint64_t mfcs_wrong_if;
};

struct rtgenmsg {
 unsigned char rtgen_family;
};

struct ifinfomsg {
 unsigned char ifi_family;
 unsigned char __ifi_pad;
 unsigned short ifi_type;
 int ifi_index;
 unsigned ifi_flags;
 unsigned ifi_change;
};

struct prefixmsg {
 unsigned char prefix_family;
 unsigned char prefix_pad1;
 unsigned short prefix_pad2;
 int prefix_ifindex;
 unsigned char prefix_type;
 unsigned char prefix_len;
 unsigned char prefix_flags;
 unsigned char prefix_pad3;
};

enum
{
 PREFIX_UNSPEC,
 PREFIX_ADDRESS,
 PREFIX_CACHEINFO,
 __PREFIX_MAX,
 PREFIX_MAX = (__PREFIX_MAX - 1),
};


struct prefix_cacheinfo {
 uint32_t preferred_time;
 uint32_t valid_time;
};

struct tcmsg {
 unsigned char tcm_family;
 unsigned char tcm__pad1;
 unsigned short tcm__pad2;
 int tcm_ifindex;
 uint32_t tcm_handle;
 union  {
  uint32_t tcm_parent;
  uint32_t tcm_block_index;
 };
 uint32_t tcm_info;
};

enum { TCM_IFINDEX_MAGIC_BLOCK = 0xFFFFFFFFU, };

enum {
 TCA_UNSPEC,
 TCA_KIND,
 TCA_OPTIONS,
 TCA_STATS,
 TCA_XSTATS,
 TCA_RATE,
 TCA_FCNT,
 TCA_STATS2,
 TCA_STAB,
 TCA_PAD,
 TCA_DUMP_INVISIBLE,
 TCA_CHAIN,
 TCA_HW_OFFLOAD,
 TCA_INGRESS_BLOCK,
 TCA_EGRESS_BLOCK,
 TCA_DUMP_FLAGS,
 TCA_EXT_WARN_MSG,
 __TCA_MAX,
 TCA_MAX = (__TCA_MAX - 1),
};

enum { TCA_DUMP_FLAGS_TERSE = (1 << 0), };

/*
#define TCA_RTA(r) ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct tcmsg))))
#define TCA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct tcmsg))
*/

struct nduseroptmsg {
 unsigned char nduseropt_family;
 unsigned char nduseropt_pad1;
 unsigned short nduseropt_opts_len;
 int nduseropt_ifindex;
 uint8_t nduseropt_icmp_type;
 uint8_t nduseropt_icmp_code;
 unsigned short nduseropt_pad2;
 unsigned int nduseropt_pad3;

};

enum {
 NDUSEROPT_UNSPEC,
 NDUSEROPT_SRCADDR,
 __NDUSEROPT_MAX,
 NDUSEROPT_MAX = (__NDUSEROPT_MAX - 1),
};

enum {
 RTMGRP_LINK = 1,
 RTMGRP_NOTIFY = 2,
 RTMGRP_NEIGH = 4,
 RTMGRP_TC = 8,

 RTMGRP_IPV4_IFADDR = 0x10,
 RTMGRP_IPV4_MROUTE = 0x20,
 RTMGRP_IPV4_ROUTE = 0x40,
 RTMGRP_IPV4_RULE = 0x80,

 RTMGRP_IPV6_IFADDR = 0x100,
 RTMGRP_IPV6_MROUTE = 0x200,
 RTMGRP_IPV6_ROUTE = 0x400,
 RTMGRP_IPV6_IFINFO = 0x800,

 RTMGRP_DECnet_IFADDR = 0x1000,
 RTMGRP_DECnet_ROUTE = 0x4000,

 RTMGRP_IPV6_PREFIX = 0x20000,
};

enum rtnetlink_groups {
 RTNLGRP_NONE,
 RTNLGRP_LINK,
 RTNLGRP_NOTIFY,
 RTNLGRP_NEIGH,
 RTNLGRP_TC,
 RTNLGRP_IPV4_IFADDR,
 RTNLGRP_IPV4_MROUTE,
 RTNLGRP_IPV4_ROUTE,
 RTNLGRP_IPV4_RULE,
 RTNLGRP_IPV6_IFADDR,
 RTNLGRP_IPV6_MROUTE,
 RTNLGRP_IPV6_ROUTE,
 RTNLGRP_IPV6_IFINFO,
 RTNLGRP_DECnet_IFADDR,
 RTNLGRP_NOP2,
 RTNLGRP_DECnet_RULE,
 RTNLGRP_NOP4,
 RTNLGRP_IPV6_PREFIX,
 RTNLGRP_IPV6_RULE,
 RTNLGRP_ND_USEROPT,
 RTNLGRP_PHONET_IFADDR,
 RTNLGRP_PHONET_ROUTE,
 RTNLGRP_DCB,
 RTNLGRP_IPV4_NETCONF,
 RTNLGRP_IPV6_NETCONF,
 RTNLGRP_MDB,
 RTNLGRP_MPLS_ROUTE,
 RTNLGRP_NSID,
 RTNLGRP_MPLS_NETCONF,
 RTNLGRP_IPV4_MROUTE_R,
 RTNLGRP_IPV6_MROUTE_R,
 RTNLGRP_NEXTHOP,
 RTNLGRP_BRVLAN,
 RTNLGRP_MCTP_IFADDR,
 RTNLGRP_TUNNEL,
 RTNLGRP_STATS,
 __RTNLGRP_MAX,
 RTNLGRP_MAX = (__RTNLGRP_MAX - 1),
};

struct tcamsg {
 unsigned char tca_family;
 unsigned char tca__pad1;
 unsigned short tca__pad2;
};

enum {
 TCA_ROOT_UNSPEC,
 TCA_ROOT_TAB,
 TCA_ACT_TAB = TCA_ROOT_TAB,
 TCAA_MAX = TCA_ROOT_TAB,
 TCA_ROOT_FLAGS,
 TCA_ROOT_COUNT,
 TCA_ROOT_TIME_DELTA,
 TCA_ROOT_EXT_WARN_MSG,
 __TCA_ROOT_MAX,
 TCA_ROOT_MAX = (__TCA_ROOT_MAX - 1),
};

/*
#define TA_RTA(r) ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct tcamsg))))
#define TA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct tcamsg))
*/

enum {
 TCA_FLAG_LARGE_DUMP_ON = (1 << 0),
 TCA_ACT_FLAG_LARGE_DUMP_ON = TCA_FLAG_LARGE_DUMP_ON,
 TCA_ACT_FLAG_TERSE_DUMP = (1 << 1),

 RTEXT_FILTER_VF = (1 << 0),
 RTEXT_FILTER_BRVLAN = (1 << 1),
 RTEXT_FILTER_BRVLAN_COMPRESSED = (1 << 2),
 RTEXT_FILTER_SKIP_STATS = (1 << 3),
 RTEXT_FILTER_MRP = (1 << 4),
 RTEXT_FILTER_CFM_CONFIG = (1 << 5),
 RTEXT_FILTER_CFM_STATUS = (1 << 6),
 RTEXT_FILTER_MST = (1 << 7),
};


