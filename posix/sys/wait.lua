--
-- p o s i x . s y s . w a i t
--
local wait = { }

local ffi	= require('ffi')
local  C	=  ffi.C
local bit	= require('bit')

		  require('posix.sys.types')

ffi.cdef([[
enum {
	WNOHANG		= 1,
	WUNTRACED	= 2,

	WSTOPPED	= 2,
	WEXITED		= 4,
	WCONTINUED	= 8,
	WNOWAIT		= 0x01000000.
	WCOREFLAG	= 0x80,
};
pid_t wait(int *wstatus);
pid_t waitpid(pid_t pid, int *wstatus, int options);
]])

function wait.WEXITSTATUS(wstatus)
	return bit.rshift(bit.band(wstatus, 0xff00), 8)
end

function wait.WIFEXITED(wstatus)
	return wait.WEXITSTATUS(wstatus) == 0
end

function wait.WIFSIGNALED(wstatus)
	return bit.rshift(bit.band(wstatus, 0x7f) + 1, 1) > 0
end

function wait.WTERMSIG(wstatus)
	return bit.band(wstatus, 0x7f)
end

function wait.WCOREDUMP(wstatus)
	return bit.band(wstatus, C.WCOREFLAG)
end

wait.WSTOPSIG = wait.WEXITSTATUS

-- WIFCONTINUED(wstatus) not-implemented

return setmetatable(wait, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
