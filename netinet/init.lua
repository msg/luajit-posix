--
-- p o s i x . n e t i n e t . i n i t
--
local M = { }

local path = ... .. '.'

M.netinet_in	= require(path .. 'in')

return M
