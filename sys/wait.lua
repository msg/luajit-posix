--
-- p o s i x . s y s . w a i t
--
local wait = { }

local ffi = require('ffi')
local bit = require('bit')

require('posix.sys.types')

ffi.cdef([[
	pid_t wait(int *wstatus);
	pid_t waitpid(pid_t pid, int *wstatus, int options);
]])

wait.WNOHANG	= 1
wait.WUNTRACED	= 2

wait.WSTOPPED	= 2
wait.WEXITED	= 4
wait.WCONTINUED	= 8
wait.WNOWAIT	= 0x01000000

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

wait.WCOREFLAG = 0x80
function wait.WCOREDUMP(wstatus)
	return bit.band(wstatus, wait.WCOREFLAG)
end

wait.WSTOPSIG = wait.WEXITSTATUS

-- WIFCONTINUED(wstatus) not-implemented

return wait
