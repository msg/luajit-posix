#!/usr/bin/luajit
--
-- l i n u x . i f _ a d d r
--
local if_addr = { }

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

netlink.cdef('if_addr.ffi.h')

function if_addr.IFA_RTA(r)
	return cast('struct rtattr *', cast('char *', r) +
			netlink.NLMSG_ALIGN(sizeof('struct ifaddrmsg')))
end
function if_addr.IFA_PAYLOAD(n)
	return netlink.NLMSG_PAYLOAD(n, sizeof('struct ifaddrmsg'))
end

return if_addr
