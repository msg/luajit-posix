--
-- l i n u x . p t y
--
local pty = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')
		  require('posix.termios')

ffi.cdef([[

int openpty(int *amaster, int *aslave, char *name,
		const struct termios *termp,
		const struct winsize *winp);
pid_t forkpty(int *amaster, int *aslave, char *name,
		const struct termios *termp,
		const struct winsize *winp);
]])

return setmetatable(pty, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
