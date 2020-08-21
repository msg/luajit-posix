--
-- p o s i x . n e t i n e t . t c p
--
local tcp = { }

local ffi	= require('ffi')
local  C	=  ffi.C

ffi.cdef([[
enum {
	TCP_NODELAY			= 1,
	TCP_MAXSEG			= 2,
	TCP_CORK			= 3,
	TCP_KEEPIDLE			= 4,
	TCP_KEEPINTVL			= 5,
	TCP_KEEPCNT			= 6,
	TCP_SYNCNT			= 7,
	TCP_LINGER2			= 8,
	TCP_DEFER_ACCEPT		= 9,
	TCP_WINDOW_CLAMP		= 10,
	TCP_INFO			= 11,
	TCP_QUICKACK			= 12,
	TCP_CONGESTION			= 13,
	TCP_MD5SIG			= 14,
	TCP_COOKIE_TRANSACTIONS		= 15,
	TCP_THIN_LINEAR_TIMEOUTS	= 16,
	TCP_THIN_DUPACK			= 17,
	TCP_USER_TIMEOUT		= 18,
	TCP_REPAIR			= 19,
	TCP_REPAIR_QUEUE		= 20,
	TCP_QUEUE_SEQ			= 21,
	TCP_REPAIR_OPTIONS		= 22,
	TCP_FASTOPEN			= 23,
	TCP_TIMESTAMP			= 24,
	TCP_NOTSENT_LOWAT		= 25,
	TCP_CC_INFO			= 26,
	TCP_SAVE_SYN			= 27,
	TCP_SAVED_SYN			= 28,
};
]])

return setmetatable(tcp, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
