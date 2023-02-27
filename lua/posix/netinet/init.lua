--
-- p o s i x . n e t i n e t . i n i t
--
local init = { }

local path = ... .. '.'

init.netinet_in	= require(path .. 'in')

return init
