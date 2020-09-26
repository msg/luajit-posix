--
-- p o s i x . s y s . i n i t
--
local init = { }

init.ioctl	= require('ioctl')
init.mman	= require('mman')
init.socket	= require('socket')
init.statfs	= require('statfs')
init.time	= require('time')
init.types	= require('types')
init.uio	= require('uio')
init.wait	= require('wait')

return init
