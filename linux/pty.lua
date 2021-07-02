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
pid_t forkpty(int *amaster, char *name,
		const struct termios *termp,
		const struct winsize *winp);
]])

local lib	= ffi.load('util')
pty.lib		= lib

return setmetatable(pty, {
	__index = function(t, n)
		local ok, v = pcall(function()
			return lib[n]
		end)
		if ok then
			return v
		end
		return t[n]
	end,
})
