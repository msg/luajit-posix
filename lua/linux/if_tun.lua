
local if_tun = { }

local ffi		= require('ffi')

local ioctl		= require('posix.sys.ioctl')
			  require('posix.sys.socket')

ffi.cdef [[
enum {
	TUN_READQ_SIZE = 500,
	IFF_TUN = 0x0001,
	IFF_TAP = 0x0002,
	IFF_NAPI = 0x0010,
	IFF_NAPI_FRAGS = 0x0020,

	IFF_NO_CARRIER = 0x0040,
	IFF_NO_PI = 0x1000,

	IFF_ONE_QUEUE = 0x2000,
	IFF_VNET_HDR = 0x4000,
	IFF_TUN_EXCL = 0x8000,
	IFF_MULTI_QUEUE = 0x0100,
	IFF_ATTACH_QUEUE = 0x0200,
	IFF_DETACH_QUEUE = 0x0400,

	IFF_PERSIST = 0x0800,
	IFF_NOFILTER = 0x1000,

	TUN_TX_TIMESTAMP = 1,

	TUN_F_CSUM = 0x01,
	TUN_F_TSO4 = 0x02,
	TUN_F_TSO6 = 0x04,
	TUN_F_TSO_ECN = 0x08,
	TUN_F_UFO = 0x10,
	TUN_F_USO4 = 0x20,
	TUN_F_USO6 = 0x40,

	TUN_TYPE_MASK = 0x000f,
	TUN_PKT_STRIP = 0x0001,
	TUN_FLT_ALLMULTI = 0x0001,
};

struct tun_pi {
 uint16_t flags;
 uint16_t proto;
};

struct tun_filter {
 uint16_t flags;
 uint16_t count;
 uint8_t addr[][6];
};
]]

if_tun.TUNSETNOCSUM	= ioctl._IOW('T', 200, 'int')
if_tun.TUNSETDEBUG	= ioctl._IOW('T', 201, 'int')
if_tun.TUNSETIFF	= ioctl._IOW('T', 202, 'int')
if_tun.TUNSETPERSIST	= ioctl._IOW('T', 203, 'int')
if_tun.TUNSETOWNER	= ioctl._IOW('T', 204, 'int')
if_tun.TUNSETLINK	= ioctl._IOW('T', 205, 'int')
if_tun.TUNSETGROUP	= ioctl._IOW('T', 206, 'int')
if_tun.TUNGETFEATURES	= ioctl._IOR('T', 207, 'unsigned int')
if_tun.TUNSETOFFLOAD	= ioctl._IOW('T', 208, 'unsigned int')
if_tun.TUNSETTXFILTER	= ioctl._IOW('T', 209, 'unsigned int')
if_tun.TUNGETIFF	= ioctl._IOR('T', 210, 'unsigned int')
if_tun.TUNGETSNDBUF	= ioctl._IOR('T', 211, 'int')
if_tun.TUNSETSNDBUF	= ioctl._IOW('T', 212, 'int')
--if_tun.TUNATTACHFILTER	= ioctl._IOW('T', 213, 'struct sock_fprog')
--if_tun.TUNDETACHFILTER	= ioctl._IOW('T', 214, 'struct sock_fprog')
if_tun.TUNGETVNETHDRSZ	= ioctl._IOR('T', 215, 'int')
if_tun.TUNSETVNETHDRSZ	= ioctl._IOW('T', 216, 'int')
if_tun.TUNSETQUEUE	= ioctl._IOW('T', 217, 'int')
if_tun.TUNSETIFINDEX	= ioctl._IOW('T', 218, 'unsigned int')
--if_tun.TUNGETFILTER	= ioctl._IOR('T', 219, 'struct sock_fprog')
if_tun.TUNSETVNETLE	= ioctl._IOW('T', 220, 'int')
if_tun.TUNGETVNETLE	= ioctl._IOR('T', 221, 'int')

if_tun.TUNSETVNETBE	= ioctl._IOW('T', 222, 'int')
if_tun.TUNGETVNETBE	= ioctl._IOR('T', 223, 'int')
if_tun.TUNSETSTEERINGEBPF	= ioctl._IOR('T', 224, 'int')
if_tun.TUNSETFILTEREBPF	= ioctl._IOR('T', 225, 'int')
if_tun.TUNSETCARRIER	= ioctl._IOW('T', 226, 'int')
if_tun.TUNGETDEVNETNS	= ioctl._IO('T', 227)

return if_tun

