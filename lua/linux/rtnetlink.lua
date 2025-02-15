#!/usr/bin/luajit
--
-- l i n u x . r t n e t l i n k
--
local rtnetlink = { }

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

netlink.cdef('rtnetlink.ffi.h')

function rtnetlink.RTM_FAM(cmd)
	return rshift(cmd - C.RTM_BASE, 2)
end

function rtnetlink.RTA_ALIGN(len)
	return band(len + C.RTA_ALIGNTO - 1, bnot(C.RTA_ALIGNTO - 1))
end
function rtnetlink.RTA_OK(rta, len)
	return len >= sizeof('struct rtattr') and
		rta.rta_len >= sizeof('struct rtattr') and
		rta.rta_len <= len
end
function rtnetlink.RTA_NEXT(rta, attrlen)
	return cast('struct rtattr *', cast('char *', rta) +
			rtnetlink.RTA_ALIGN(rta.rta_len)),
		attrlen - rtnetlink.RTA_ALIGN(rta.rta_len)
end
function rtnetlink.RTA_LENGTH(len)
	return rtnetlink.RTA_ALIGN(sizeof('struct rtattr') + len)
end
function rtnetlink.RTA_SPACE(len)
	return rtnetlink.RTA_ALIGN(rtnetlink.RTA_LENGTH(len))
end
function rtnetlink.RTA_DATA(rta)
	return cast('void *', cast('char *', rta) +
			rtnetlink.RTA_LENGTH(0))
end
function rtnetlink.RTA_PAYLOAD(rta)
	return rta.rta_len - rtnetlink.RTA_LENGTH(0)
end

function rtnetlink.RTM_RTA(r)
	return cast('struct rtattr *', cast('char *', r) +
			netlink.NLMSG_ALIGN(sizeof('struct rtmsg')))
end
function rtnetlink.RTM_PAYLOAD(n)
	return netlink.NLMSG_PAYLOAD(n, sizeof('struct rtmsg'))
end

function rtnetlink.RTNH_ALIGN(len)
	return band(len + C.RTNH_ALIGNTO-1, bnot(C.RTNH_ALIGNTO-1))
end
function rtnetlink.RTNH_OK(rtnh, len)
	return rtnh.rtnh_len >= sizeof('struct rtnexthop') and
		rtnh.rtnh_len <= len
end
function rtnetlink.RTNH_NEXT(rtnh)
	return cast('struct rtnexthop *', cast('char *', rtnh) +
			rtnetlink.RTNH_ALIGN(rtnh.rtnh_len))
end
function rtnetlink.RTNH_LENGTH(len)
	return rtnetlink.RTNH_ALIGN(sizeof('struct rtnexthop')) + len
end
function rtnetlink.RTNH_SPACE(len)
	return rtnetlink.RTNH_ALIGN(rtnetlink.RTNH_LENGTH(len))
end
function rtnetlink.RTNH_DATA(rtnh)
	return cast('struct rtattr *', cast('char *', rtnh) +
			rtnetlink.RTNH_LENGTH(0))
end

function rtnetlink.TCA_RTA(r)
	return cast('struct rtattr *', cast('char*', r) +
				netlink.NLMSG_ALIGN(sizeof('struct tcmsg')))
end
function rtnetlink.TCA_PAYLOAD(n)
	return netlink.NLMSG_PAYLOAD(n, sizeof('struct tcmsg'))
end

function rtnetlink.TA_RTA(r)
	return cast('struct rtattr *', cast('char *', r) +
			netlink.NLMSG_ALIGN(sizeof('struct tcamsg')))
end
function rtnetlink.TA_PAYLOAD(n)
	return netlink.NLMSG_PAYLOAD(n, sizeof('struct tcamsg'))
end

return rtnetlink

