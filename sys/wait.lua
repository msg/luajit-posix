--
-- p o s i x . s y s . w a i t
--
module(..., package.seeall)

local ffi = require('ffi')
local bit = require('bit')

local sys_types = require('posix.sys.types')

ffi.cdef([[
	pid_t wait(int *wstatus);
	pid_t waitpid(pid_t pid, int *wstatus, int options);
]])

WNOHANG		= 1
WUNTRACED	= 2

WSTOPPED	= 2
WEXITED		= 4
WCONTINUED	= 8
WNOWAIT		= 0x01000000

function WEXITSTATUS(wstatus)
	return bit.rshift(bit.band(wstatus, 0xff00), 8)
end

function WIFEXITED(wstatus)
	return WEXITSTATUS == 0
end

function WIFSIGNALED(wstatus)
	return bit.rshift(bit.band(wstatus, 0x7f) + 1, 1) > 0
end

function WTERMSIG(wstatus)
	return bit.band(wstatus, 0x7f)
end

WCOREFLAG = 0x80
function WCOREDUMP(wstatus)
	return bit.band(wstatus, WCOREFLAG)
end

WSTOPSIG = WEXITSTATUS

-- WIFCONTINUED(wstatus) not-implemented
