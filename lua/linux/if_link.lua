#!/usr/bin/luajit
--
-- l i n u x . i f _ l i n k
--
local if_link = { }

-- luacheck: push ignore
local ffi		= require('ffi')
local  C		=  ffi.C
local  cast		=  ffi.cast
local  copy		=  ffi.copy
local  errno		=  ffi.errno
local  fstring		=  ffi.string
local  gc		=  ffi.gc
local  metatype		=  ffi.metatype
local  new		=  ffi.new
local  offsetof		=  ffi.offsetof
local  sizeof		=  ffi.sizeof
local  typeof		=  ffi.typeof
-- luacheck: pop
-- luacheck: push ignore
local bit		= require('bit')
local  arshift		=  bit.arshift
local  band		=  bit.band
local  bnot		=  bit.bnot
local  bor		=  bit.bor
local  bswap		=  bit.bswap
local  bxor		=  bit.bxor
local  lshift		=  bit.lshift
local  rol		=  bit.rol
local  ror		=  bit.ror
local  rshift		=  bit.rshift
local  tobit		=  bit.tobit
local  tohex		=  bit.tohex
-- luacheck: pop

local netlink		= require('linux.netlink')

netlink.cdef('if_link.ffi.h')

function if_link.IFLA_RTA(r)
	return cast('struct rtattr *', cast('char *', r) +
			netlink.NLMSG_ALIGN(sizeof('struct ifinfomsg')))
end
function if_link.IFLA_PAYLOAD(n)
	return netlink.NLMSG_PAYLOAD(n, sizeof('struct ifinfomsg'))
end
function if_link.IFLA_STATS_FILTER_BIT(ATTR)
	return lshift(1, ATTR - 1)
end

return if_link
