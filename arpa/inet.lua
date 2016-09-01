--
-- p o s i x . i n e t
--
module(..., package.seeall)

local ffi		= require('ffi')
local netinet_in	= require('posix.netinet.in')
local sys_types		= require('posix.sys.types')

ffi.cdef([[
	uint32_t ntohl (uint32_t netlong);
	uint16_t ntohs (uint16_t netshort);
	uint32_t htonl (uint32_t hostlong);
	uint16_t htons (uint16_t hostshort);
	in_addr_t inet_addr (const char *cp);
	char *inet_ntoa (struct in_addr in);
	const char *inet_ntop(int af, const void *cp, char *buf, socklen_t len);
	int inet_pton (int af, const char *cp, void *buf);
]])
