--
-- p o s i x . s y s . w a i t
--
local M = { }

local ffi = require('ffi')
local bit = require('bit')

local sys_types = require('posix.sys.types')

ffi.cdef([[
	pid_t wait(int *wstatus);
	pid_t waitpid(pid_t pid, int *wstatus, int options);
]])

M.WNOHANG	= 1
M.WUNTRACED	= 2

M.WSTOPPED	= 2
M.WEXITED	= 4
M.WCONTINUED	= 8
M.WNOWAIT	= 0x01000000

function M.WEXITSTATUS(wstatus)
	return bit.rshift(bit.band(wstatus, 0xff00), 8)
end

function M.WIFEXITED(wstatus)
	return M.WEXITSTATUS(wstatus) == 0
end

function M.WIFSIGNALED(wstatus)
	return bit.rshift(bit.band(wstatus, 0x7f) + 1, 1) > 0
end

function M.WTERMSIG(wstatus)
	return bit.band(wstatus, 0x7f)
end

M.WCOREFLAG = 0x80
function M.WCOREDUMP(wstatus)
	return bit.band(wstatus, M.WCOREFLAG)
end

M.WSTOPSIG = M.WEXITSTATUS

-- WIFCONTINUED(wstatus) not-implemented

return M
