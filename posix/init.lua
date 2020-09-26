--
-- p o s i x . i n i t
--
local init = { }

local path = ... .. '.'
init.dirent	= require(path .. 'dirent')
init.fcntl	= require(path .. 'fcntl')
init.netdb	= require(path .. 'netdb')
init.poll	= require(path .. 'poll')
init.stdio	= require(path .. 'stdio')
init.string	= require(path .. 'string')
init.time	= require(path .. 'time')
init.unistd	= require(path .. 'unistd')

init.arpa	= require(path .. 'arpa')
init.netinet	= require(path .. 'netinet')
--init.std	= require(path .. 'std')

return init
