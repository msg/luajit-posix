--
-- p o s i x . s y s . i o c t l
--
local M = { }

local ffi = require('ffi')
local bit = require('bit')

ffi.cdef([[ int ioctl(int fd, unsigned long int req, ...); ]])

local byte = string.byte

-- ioctl
M._IOC_NRBITS	= 8
M._IOC_TYPEBITS	= 8

-- Let any architecture override either of the following before
-- including this file.
M._IOC_SIZEBITS	= 14
M._IOC_DIRBITS	= 2

M._IOC_NRMASK	= bit.lshift(1, M._IOC_NRBITS)-1
M._IOC_TYPEMASK	= bit.lshift(1, M._IOC_TYPEBITS)-1
M._IOC_SIZEMASK	= bit.lshift(1, M._IOC_SIZEBITS)-1
M._IOC_DIRMASK	= bit.lshift(1, M._IOC_DIRBITS)-1

M._IOC_NRSHIFT		= 0
M._IOC_TYPESHIFT	= M._IOC_NRSHIFT + M._IOC_NRBITS
M._IOC_SIZESHIFT	= M._IOC_TYPESHIFT + M._IOC_TYPEBITS
M._IOC_DIRSHIFT		= M._IOC_SIZESHIFT + M._IOC_SIZEBITS

-- Direction bits, which any architecture can choose to override
-- before including this file.
M._IOC_NONE	= 0
M._IOC_WRITE	= 1
M._IOC_READ	= 2

function M._IOC(dir, type, nr, size)
	return bit.bor(bit.lshift(dir,  M._IOC_DIRSHIFT),
			bit.lshift(byte(type), M._IOC_TYPESHIFT),
			bit.lshift(nr,   M._IOC_NRSHIFT),
			bit.lshift(size, M._IOC_SIZESHIFT))
end

function M._IOC_TYPECHECK(t)
	return ffi.sizeof(t)
end

-- used to create numbers
function M._IO(type, nr)
	return M._IOC(M._IOC_NONE, type, nr, 0)
end
function M._IOR(type, nr, size)
	return M._IOC(M._IOC_READ, type, nr, M._IOC_TYPECHECK(size))
end
function M._IOW(type,nr,size)
	return M._IOC(M._IOC_WRITE, type, nr, M._IOC_TYPECHECK(size))
end
function M._IOWR(type,nr,size)
	return M._IOC(bit.bor(M._IOC_READ, M._IOC_WRITE),
			type, nr, M._IOC_TYPECHECK(size))
end
function M._IOR_BAD(type, nr, size)
	return M._IOC(M._IOC_READ, type, nr, #size)
end
function M._IOW_BAD(type, nr, size)
	return M._IOC(M._IOC_WRITE, type, nr, #size)
end
function M._IOWR_BAD(type,nr,size)
	return M._IOC(bit.bor(M._IOC_READ, M._IOC_WRITE), type, nr,#size)
end

function M._IOC_DIR(nr)
	return bit.band(bit.rshift(nr, M._IOC_DIRSHIFT), M._IOC_DIRMASK)
end
function M._IOC_TYPE(nr)
	return bit.band(bit.rshift(nr, M._IOC_TYPESHIFT), M._IOC_TYPEMASK)
end
function M._IOC_NR(nr)
	return bit.band(bit.rshift(nr, M._IOC_NRSHIFT), M._IOC_NRMASK)
end
function M._IOC_SIZE(nr)
	return bit.band(bit.rshift(nr, M._IOC_SIZESHIFT), M._IOC_SIZEMASK)
end

-- ...and for the drivers/sound files...

M.IOC_IN	= bit.lshift(M._IOC_WRITE, M._IOC_DIRSHIFT)
M.IOC_OUT	= bit.lshift(M._IOC_READ, M._IOC_DIRSHIFT)
M.IOC_INOUT	= bit.lshift(bit.bor(M._IOC_WRITE, M._IOC_READ), M._IOC_DIRSHIFT)
M.IOCSIZE_MASK	= bit.lshift(M._IOC_SIZEMASK, M._IOC_SIZESHIFT)
M.IOCSIZE_SHIFT	= M._IOC_SIZESHIFT

return M
