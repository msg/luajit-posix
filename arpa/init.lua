--
-- p o s i x . a r p a . i n i t
--
local init = { }

local path = ... .. '.'

init.inet	= require(path .. 'inet')

return init
