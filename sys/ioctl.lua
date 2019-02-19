--
-- p o s i x . s y s . i o c t l
--
local ioctl = { }

local ffi = require('ffi')
local bit = require('bit')

ffi.cdef([[ int ioctl(int fd, unsigned long int req, ...); ]])

local byte = string.byte

-- ioctl
ioctl._IOC_NRBITS	= 8
ioctl._IOC_TYPEBITS	= 8

-- Let any architecture override either of the following before
-- including this file.
ioctl._IOC_SIZEBITS	= 14
ioctl._IOC_DIRBITS	= 2

ioctl._IOC_NRMASK	= bit.lshift(1, ioctl._IOC_NRBITS)-1
ioctl._IOC_TYPEMASK	= bit.lshift(1, ioctl._IOC_TYPEBITS)-1
ioctl._IOC_SIZEMASK	= bit.lshift(1, ioctl._IOC_SIZEBITS)-1
ioctl._IOC_DIRMASK	= bit.lshift(1, ioctl._IOC_DIRBITS)-1

ioctl._IOC_NRSHIFT	= 0
ioctl._IOC_TYPESHIFT	= ioctl._IOC_NRSHIFT + ioctl._IOC_NRBITS
ioctl._IOC_SIZESHIFT	= ioctl._IOC_TYPESHIFT + ioctl._IOC_TYPEBITS
ioctl._IOC_DIRSHIFT	= ioctl._IOC_SIZESHIFT + ioctl._IOC_SIZEBITS

-- Direction bits, which any architecture can choose to override
-- before including this file.
ioctl._IOC_NONE		= 0
ioctl._IOC_WRITE	= 1
ioctl._IOC_READ		= 2

function ioctl._IOC(dir, type, nr, size)
	return bit.bor(bit.lshift(dir,  ioctl._IOC_DIRSHIFT),
			bit.lshift(byte(type), ioctl._IOC_TYPESHIFT),
			bit.lshift(nr,   ioctl._IOC_NRSHIFT),
			bit.lshift(size, ioctl._IOC_SIZESHIFT))
end

function ioctl._IOC_TYPECHECK(t)
	return ffi.sizeof(t)
end

-- used to create numbers
function ioctl._IO(type, nr)
	return ioctl._IOC(ioctl._IOC_NONE, type, nr, 0)
end
function ioctl._IOR(type, nr, size)
	return ioctl._IOC(ioctl._IOC_READ,
			type, nr, ioctl._IOC_TYPECHECK(size))
end
function ioctl._IOW(type,nr,size)
	return ioctl._IOC(ioctl._IOC_WRITE,
			type, nr, ioctl._IOC_TYPECHECK(size))
end
function ioctl._IOWR(type,nr,size)
	return ioctl._IOC(bit.bor(ioctl._IOC_READ, ioctl._IOC_WRITE),
			type, nr, ioctl._IOC_TYPECHECK(size))
end
function ioctl._IOR_BAD(type, nr, size)
	return ioctl._IOC(ioctl._IOC_READ, type, nr, #size)
end
function ioctl._IOW_BAD(type, nr, size)
	return ioctl._IOC(ioctl._IOC_WRITE, type, nr, #size)
end
function ioctl._IOWR_BAD(type,nr,size)
	return ioctl._IOC(bit.bor(ioctl._IOC_READ, ioctl._IOC_WRITE),
			type, nr,#size)
end

function ioctl._IOC_DIR(nr)
	return bit.band(bit.rshift(nr, ioctl._IOC_DIRSHIFT),
			ioctl._IOC_DIRMASK)
end
function ioctl._IOC_TYPE(nr)
	return bit.band(bit.rshift(nr, ioctl._IOC_TYPESHIFT),
			ioctl._IOC_TYPEMASK)
end
function ioctl._IOC_NR(nr)
	return bit.band(bit.rshift(nr, ioctl._IOC_NRSHIFT),
			ioctl._IOC_NRMASK)
end
function ioctl._IOC_SIZE(nr)
	return bit.band(bit.rshift(nr, ioctl._IOC_SIZESHIFT),
			ioctl._IOC_SIZEMASK)
end

-- ...and for the drivers/sound files...

ioctl.IOC_IN		= bit.lshift(ioctl._IOC_WRITE, ioctl._IOC_DIRSHIFT)
ioctl.IOC_OUT		= bit.lshift(ioctl._IOC_READ, ioctl._IOC_DIRSHIFT)
ioctl.IOC_INOUT		= bit.lshift(bit.bor(ioctl._IOC_WRITE, ioctl._IOC_READ),
					ioctl._IOC_DIRSHIFT)
ioctl.IOCSIZE_MASK	= bit.lshift(ioctl._IOC_SIZEMASK, ioctl._IOC_SIZESHIFT)
ioctl.IOCSIZE_SHIFT	= ioctl._IOC_SIZESHIFT

return ioctl
