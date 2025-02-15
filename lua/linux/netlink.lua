#!/usr/bin/luajit
--
-- l i n u x . n e t l i n k
--
local netlink = { }

local  format		=  string.format

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

local function get_path()
	local path	= debug.getinfo(function() end).source:sub(2)
	return path:sub(1, path:find('[^/]+$')-1)
end

netlink.path = get_path()

local function read_path(path)
	local f = io.open(path)
	if f ~= nil then
		return f:read('*a')
	end
end

netlink.cdef = function(name)
	ffi.cdef(read_path(netlink.path..'/include/'..name))
end

netlink.cdef('netlink.ffi.h')

local function cdefenum(name, value)
	ffi.cdef(format('enum { %s = %d, };', name, value))
end

function netlink.NLMSG_ALIGN(len)
	return band(len + C.NLMSG_ALIGNTO - 1, bnot(C.NLMSG_ALIGNTO - 1))
end
cdefenum('NLMSG_HDRLEN', netlink.NLMSG_ALIGN(sizeof('struct nlmsghdr')))
function netlink.NLMSG_LENGTH(len)
	return len + C.NLMSG_HDRLEN
end
function netlink.NLMSG_SPACE(len)
	return netlink.NLMSG_ALIGN(netlink.NLMSG_LENGTH(len))
end
function netlink.NLMSG_DATA(nlh)
	return cast('void *', cast('char *', nlh) + C.NLMSG_HDRLEN)
end
function netlink.NLMSG_NEXT(nlh, len)
	return cast('struct nlmsghdr *',
		cast('char *', nlh) + netlink.NLMSG_ALIGN(nlh.nlmsg_len)),
		len - netlink.NLMSG_ALIGN(nlh.nlmsg_len)
end
function netlink.NLMSG_OK(nlh, len)
	return len >= sizeof('struct nlmsghdr') and
		nlh.nlmsg_len >= sizeof('struct nlmsghdr') and
		nlh.nlmsg_len <= len
end
function netlink.NLMSG_PAYLOAD(nlh, len)
	return nlh.nlmsg_len - netlink.NLMSG_SPACE(len)
end

local function __ALIGN_KERNEL_MASK(x, mask)
	return band(x + mask, bnot(mask))
end
local function __ALIGN_KERNEL(x, a)
	return __ALIGN_KERNEL_MASK(x, a - 1)
end
function netlink.NL_MMAP_MSG_ALIGN(sz)
	return __ALIGN_KERNEL(sz, C.NL_MMAP_MSG_ALIGNMENT)
end
cdefenum('NL_MMAP_HDRLEN', netlink.NL_MMAP_MSG_ALIGN(sizeof('struct nl_mmap_hdr')))

function netlink.NLA_ALIGN(len)
	return band(len + C.NLA_ALIGNTO - 1, bnot(C.NLA_ALIGNTO - 1))
end
cdefenum('NLA_HDRLEN', netlink.NLA_ALIGN(sizeof('struct nlattr')))

return netlink
