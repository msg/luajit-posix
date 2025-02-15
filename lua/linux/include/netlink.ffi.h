
enum {
NETLINK_ROUTE = 0,
NETLINK_UNUSED = 1,
NETLINK_USERSOCK = 2,
NETLINK_FIREWALL = 3,
NETLINK_SOCK_DIAG = 4,
NETLINK_NFLOG = 5,
NETLINK_XFRM = 6,
NETLINK_SELINUX = 7,
NETLINK_ISCSI = 8,
NETLINK_AUDIT = 9,
NETLINK_FIB_LOOKUP = 10,
NETLINK_CONNECTOR = 11,
NETLINK_NETFILTER = 12,
NETLINK_IP6_FW = 13,
NETLINK_DNRTMSG = 14,
NETLINK_KOBJECT_UEVENT = 15,
NETLINK_GENERIC = 16,

NETLINK_SCSITRANSPORT = 18,
NETLINK_ECRYPTFS = 19,
NETLINK_RDMA = 20,
NETLINK_CRYPTO = 21,
NETLINK_SMC = 22,

NETLINK_INET_DIAG = NETLINK_SOCK_DIAG,

MAX_LINKS = 32,
};

struct sockaddr_nl {
 uint16_t nl_family;
 uint16_t nl_pad;
 uint32_t nl_pid;
 uint32_t nl_groups;
};

struct nlmsghdr {
 uint32_t nlmsg_len;
 uint16_t nlmsg_type;
 uint16_t nlmsg_flags;
 uint32_t nlmsg_seq;
 uint32_t nlmsg_pid;
};

enum {
NLM_F_REQUEST = 0x01,
NLM_F_MULTI = 0x02,
NLM_F_ACK = 0x04,
NLM_F_ECHO = 0x08,
NLM_F_DUMP_INTR = 0x10,
NLM_F_DUMP_FILTERED = 0x20,
};

enum {
NLM_F_ROOT = 0x100,
NLM_F_MATCH = 0x200,
NLM_F_ATOMIC = 0x400,
NLM_F_DUMP = (NLM_F_ROOT|NLM_F_MATCH),
};

enum {
NLM_F_REPLACE = 0x100,
NLM_F_EXCL = 0x200,
NLM_F_CREATE = 0x400,
NLM_F_APPEND = 0x800,
};

enum {
NLM_F_NONREC = 0x100,
NLM_F_BULK = 0x200,
};

enum {
NLM_F_CAPPED = 0x100,
NLM_F_ACK_TLVS = 0x200,
};

enum { NLMSG_ALIGNTO = 4U, };
// #define NLMSG_ALIGN(len) ( ((len)+NLMSG_ALIGNTO-1) & ~(NLMSG_ALIGNTO-1) )
// #define NLMSG_HDRLEN ((int) NLMSG_ALIGN(sizeof(struct nlmsghdr)))
// #define NLMSG_LENGTH(len) ((len) + NLMSG_HDRLEN)
// #define NLMSG_SPACE(len) NLMSG_ALIGN(NLMSG_LENGTH(len))
// #define NLMSG_DATA(nlh) ((void *)(((char *)nlh) + NLMSG_HDRLEN))
// #define NLMSG_NEXT(nlh,len) ((len) -= NLMSG_ALIGN((nlh)->nlmsg_len), \
      (struct nlmsghdr *)(((char *)(nlh)) + \
      NLMSG_ALIGN((nlh)->nlmsg_len)))
// #define NLMSG_OK(nlh,len) ((len) >= (int)sizeof(struct nlmsghdr) && \
      (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
      (nlh)->nlmsg_len <= (len))
// #define NLMSG_PAYLOAD(nlh,len) ((nlh)->nlmsg_len - NLMSG_SPACE((len)))

enum {
NLMSG_NOOP = 0x1,
NLMSG_ERROR = 0x2,
NLMSG_DONE = 0x3,
NLMSG_OVERRUN = 0x4,
};

enum {
NLMSG_MIN_TYPE = 0x10,
};

struct nlmsgerr {
 int error;
 struct nlmsghdr msg;
};

enum nlmsgerr_attrs {
 NLMSGERR_ATTR_UNUSED,
 NLMSGERR_ATTR_MSG,
 NLMSGERR_ATTR_OFFS,
 NLMSGERR_ATTR_COOKIE,
 NLMSGERR_ATTR_POLICY,
 NLMSGERR_ATTR_MISS_TYPE,
 NLMSGERR_ATTR_MISS_NEST,

 __NLMSGERR_ATTR_MAX,
 NLMSGERR_ATTR_MAX = __NLMSGERR_ATTR_MAX - 1
};

enum {
NETLINK_ADD_MEMBERSHIP = 1,
NETLINK_DROP_MEMBERSHIP = 2,
NETLINK_PKTINFO = 3,
NETLINK_BROADCAST_ERROR = 4,
NETLINK_NO_ENOBUFS = 5,
NETLINK_RX_RING = 6,
NETLINK_TX_RING = 7,
NETLINK_LISTEN_ALL_NSID = 8,
NETLINK_LIST_MEMBERSHIPS = 9,
NETLINK_CAP_ACK = 10,
NETLINK_EXT_ACK = 11,
NETLINK_GET_STRICT_CHK = 12,
};

struct nl_pktinfo {
 uint32_t group;
};

struct nl_mmap_req {
 unsigned int nm_block_size;
 unsigned int nm_block_nr;
 unsigned int nm_frame_size;
 unsigned int nm_frame_nr;
};

struct nl_mmap_hdr {
 unsigned int nm_status;
 unsigned int nm_len;
 uint32_t nm_group;

 uint32_t nm_pid;
 uint32_t nm_uid;
 uint32_t nm_gid;
};

enum nl_mmap_status {
 NL_MMAP_STATUS_UNUSED,
 NL_MMAP_STATUS_RESERVED,
 NL_MMAP_STATUS_VALID,
 NL_MMAP_STATUS_COPY,
 NL_MMAP_STATUS_SKIP,
};

enum { NL_MMAP_MSG_ALIGNMENT = NLMSG_ALIGNTO, };
// #define NL_MMAP_MSG_ALIGN(sz) __ALIGN_KERNEL(sz, NL_MMAP_MSG_ALIGNMENT)
// #define NL_MMAP_HDRLEN NL_MMAP_MSG_ALIGN(sizeof(struct nl_mmap_hdr))

enum { NET_MAJOR = 36, };

enum {
 NETLINK_UNCONNECTED = 0,
 NETLINK_CONNECTED,
};

struct nlattr {
 uint16_t nla_len;
 uint16_t nla_type;
};

enum {
NLA_F_NESTED = (1 << 15),
NLA_F_NET_BYTEORDER = (1 << 14),
NLA_TYPE_MASK = ~(NLA_F_NESTED | NLA_F_NET_BYTEORDER),
};

enum { NLA_ALIGNTO = 4, };
// #define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
// #define NLA_HDRLEN ((int) NLA_ALIGN(sizeof(struct nlattr)))

struct nla_bitfield32 {
 uint32_t value;
 uint32_t selector;
};

enum netlink_attribute_type {
 NL_ATTR_TYPE_INVALID,

 NL_ATTR_TYPE_FLAG,

 NL_ATTR_TYPE_U8,
 NL_ATTR_TYPE_U16,
 NL_ATTR_TYPE_U32,
 NL_ATTR_TYPE_U64,

 NL_ATTR_TYPE_S8,
 NL_ATTR_TYPE_S16,
 NL_ATTR_TYPE_S32,
 NL_ATTR_TYPE_S64,

 NL_ATTR_TYPE_BINARY,
 NL_ATTR_TYPE_STRING,
 NL_ATTR_TYPE_NUL_STRING,

 NL_ATTR_TYPE_NESTED,
 NL_ATTR_TYPE_NESTED_ARRAY,

 NL_ATTR_TYPE_BITFIELD32,

 NL_ATTR_TYPE_SINT,
 NL_ATTR_TYPE_UINT,
};

enum netlink_policy_type_attr {
 NL_POLICY_TYPE_ATTR_UNSPEC,
 NL_POLICY_TYPE_ATTR_TYPE,
 NL_POLICY_TYPE_ATTR_MIN_VALUE_S,
 NL_POLICY_TYPE_ATTR_MAX_VALUE_S,
 NL_POLICY_TYPE_ATTR_MIN_VALUE_U,
 NL_POLICY_TYPE_ATTR_MAX_VALUE_U,
 NL_POLICY_TYPE_ATTR_MIN_LENGTH,
 NL_POLICY_TYPE_ATTR_MAX_LENGTH,
 NL_POLICY_TYPE_ATTR_POLICY_IDX,
 NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE,
 NL_POLICY_TYPE_ATTR_BITFIELD32_MASK,
 NL_POLICY_TYPE_ATTR_PAD,
 NL_POLICY_TYPE_ATTR_MASK,

 __NL_POLICY_TYPE_ATTR_MAX,
 NL_POLICY_TYPE_ATTR_MAX = __NL_POLICY_TYPE_ATTR_MAX - 1
};

