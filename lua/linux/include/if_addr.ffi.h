
struct ifaddrmsg {
 uint8_t ifa_family;
 uint8_t ifa_prefixlen;
 uint8_t ifa_flags;
 uint8_t ifa_scope;
 uint32_t ifa_index;
};

enum IFA_ {
 IFA_UNSPEC,
 IFA_ADDRESS,
 IFA_LOCAL,
 IFA_LABEL,
 IFA_BROADCAST,
 IFA_ANYCAST,
 IFA_CACHEINFO,
 IFA_MULTICAST,
 IFA_FLAGS,
 IFA_RT_PRIORITY,
 IFA_TARGET_NETNSID,
 IFA_PROTO,
 __IFA_MAX,
 IFA_MAX = (__IFA_MAX - 1),
};

enum IFA_F_ {
 IFA_F_SECONDARY = 0x01,
 IFA_F_TEMPORARY = IFA_F_SECONDARY,

 IFA_F_NODAD = 0x02,
 IFA_F_OPTIMISTIC = 0x04,
 IFA_F_DADFAILED = 0x08,
 IFA_F_HOMEADDRESS = 0x10,
 IFA_F_DEPRECATED = 0x20,
 IFA_F_TENTATIVE = 0x40,
 IFA_F_PERMANENT = 0x80,
 IFA_F_MANAGETEMPADDR = 0x100,
 IFA_F_NOPREFIXROUTE = 0x200,
 IFA_F_MCAUTOJOIN = 0x400,
 IFA_F_STABLE_PRIVACY = 0x800,
};

struct ifa_cacheinfo {
 uint32_t ifa_prefered;
 uint32_t ifa_valid;
 uint32_t cstamp;
 uint32_t tstamp;
};

enum IFA_PROT_ {
 IFAPROT_UNSPEC = 0,
 IFAPROT_KERNEL_LO = 1,
 IFAPROT_KERNEL_RA = 2,
 IFAPROT_KERNEL_LL = 3,
};

