--
-- l i n u x / n e t / i f . l u a
--
local net_if = { }

local ffi		= require('ffi')
local  C		=  ffi.C

			  require('posix.sys.socket')

ffi.cdef([[
struct if_nameindex {
	unsigned int if_index;
	char *if_name;
};

enum {
	IFF_UP = 0x1,
	IFF_BROADCAST = 0x2,
	IFF_DEBUG = 0x4,
	IFF_LOOPBACK = 0x8,
	IFF_POINTOPOINT = 0x10,
	IFF_NOTRAILERS = 0x20,
	IFF_RUNNING = 0x40,
	IFF_NOARP = 0x80,
	IFF_PROMISC = 0x100,

	IFF_ALLMULTI = 0x200,

	IFF_MASTER = 0x400,
	IFF_SLAVE = 0x800,

	IFF_MULTICAST = 0x1000,

	IFF_PORTSEL = 0x2000,
	IFF_AUTOMEDIA = 0x4000,
	IFF_DYNAMIC = 0x8000
};

struct ifaddr {
	struct sockaddr ifa_addr;
	union {
		struct sockaddr ifu_broadaddr;
		struct sockaddr ifu_dstaddr;
	} ifa_ifu;
	struct iface *ifa_ifp;
	struct ifaddr *ifa_next;
};

struct ifmap {
	unsigned long int mem_start;
	unsigned long int mem_end;
	unsigned short int base_addr;
	unsigned char irq;
	unsigned char dma;
	unsigned char port;

};

enum {
	IF_NAMESIZE = 16,
	IFNAMSIZ = 16,
	IFHWADDRLEN = 6,
}

struct ifreq {
	union {
		char ifrn_name[16];
	} ifr_ifrn;

	union {
		struct sockaddr ifru_addr;
		struct sockaddr ifru_dstaddr;
		struct sockaddr ifru_broadaddr;
		struct sockaddr ifru_netmask;
		struct sockaddr ifru_hwaddr;
		short int ifru_flags;
		int ifru_ivalue;
		int ifru_mtu;
		struct ifmap ifru_map;
		char ifru_slave[16];
		char ifru_newname[16];
		char *ifru_data;
	} ifr_ifru;
};

struct ifconf {
	int ifc_len;
	union {
		char *ifcu_buf;
		struct ifreq *ifcu_req;
	} ifc_ifcu;
};

unsigned int if_nametoindex (const char *ifname);
char *if_indextoname (unsigned int ifindex, char ifname[16]);
struct if_nameindex *if_nameindex (void);
void if_freenameindex (struct if_nameindex *ptr);
]])

return net_if
