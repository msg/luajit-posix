--
-- p o s i x . s y s . i o c t l
--
module(..., package.seeall)

local ffi = require('ffi')
local bit = require('bit')

ffi.cdef([[ int ioctl(int fd, unsigned int req, ...); ]])

local byte = string.byte

-- ioctl
_IOC_NRBITS	= 8
_IOC_TYPEBITS	= 8

-- Let any architecture override either of the following before
-- including this file.
_IOC_SIZEBITS   = 14
_IOC_DIRBITS    = 2

_IOC_NRMASK     = bit.lshift(1, _IOC_NRBITS)-1
_IOC_TYPEMASK   = bit.lshift(1, _IOC_TYPEBITS)-1
_IOC_SIZEMASK   = bit.lshift(1, _IOC_SIZEBITS)-1
_IOC_DIRMASK    = bit.lshift(1, _IOC_DIRBITS)-1

_IOC_NRSHIFT    = 0
_IOC_TYPESHIFT  = _IOC_NRSHIFT + _IOC_NRBITS
_IOC_SIZESHIFT  = _IOC_TYPESHIFT + _IOC_TYPEBITS
_IOC_DIRSHIFT   = _IOC_SIZESHIFT + _IOC_SIZEBITS

-- Direction bits, which any architecture can choose to override
-- before including this file.
_IOC_NONE       = 0
_IOC_WRITE      = 1
_IOC_READ       = 2

function _IOC(dir, type, nr, size)
	return bit.bor(bit.lshift(dir,  _IOC_DIRSHIFT),
			bit.lshift(byte(type), _IOC_TYPESHIFT),
			bit.lshift(nr,   _IOC_NRSHIFT),
			bit.lshift(size, _IOC_SIZESHIFT))
end

function _IOC_TYPECHECK(t)
	return ffi.sizeof(t)
end

-- used to create numbers
function _IO(type, nr)
	return _IOC(_IOC_NONE, type, nr, 0)
end
function _IOR(type, nr, size)
	return _IOC(_IOC_READ, type, nr, _IOC_TYPECHECK(size))
end
function _IOW(type,nr,size)
	return _IOC(_IOC_WRITE, type, nr, _IOC_TYPECHECK(size))
end
function _IOWR(type,nr,size)
	return _IOC(bit.bor(_IOC_READ, _IOC_WRITE),
			type, nr, _IOC_TYPECHECK(size))
end
function _IOR_BAD(type, nr, size)
	return _IOC(_IOC_READ, type, nr, #size)
end
function _IOW_BAD(type, nr, size)
	return _IOC(_IOC_WRITE, type, nr, #size)
end
function _IOWR_BAD(type,nr,size)
	return _IOC(bit.bor(_IOC_READ, _IOC_WRITE), type, nr,#size)
end

function _IOC_DIR(nr)
	return bit.band(bit.rshift(nr, _IOC_DIRSHIFT), _IOC_DIRMASK)
end
function _IOC_TYPE(nr)
	return bit.band(bit.rshift(nr, _IOC_TYPESHIFT), _IOC_TYPEMASK)
end
function _IOC_NR(nr)
	return bit.band(bit.rshift(nr, _IOC_NRSHIFT), _IOC_NRMASK)
end
function _IOC_SIZE(nr)
	return bit.band(bit.rshift(nr, _IOC_SIZESHIFT), _IOC_SIZEMASK)
end

-- ...and for the drivers/sound files...

IOC_IN          = bit.lshift(_IOC_WRITE, _IOC_DIRSHIFT)
IOC_OUT         = bit.lshift(_IOC_READ, _IOC_DIRSHIFT)
IOC_INOUT       = bit.lshift(bit.bor(_IOC_WRITE, _IOC_READ), _IOC_DIRSHIFT)
IOCSIZE_MASK    = bit.lshift(_IOC_SIZEMASK, _IOC_SIZESHIFT)
IOCSIZE_SHIFT   = _IOC_SIZESHIFT

