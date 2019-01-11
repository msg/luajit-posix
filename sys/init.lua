--
-- p o s i x . s y s . i n i t
--
local M = { }

M.ioctl		= require('ioctl')
M.mman		= require('mman')
M.socket	= require('socket')
M.statfs	= require('statfs')
M.time		= require('time')
M.types		= require('types')
M.uio		= require('uio')
M.wait		= require('wait')

return M
