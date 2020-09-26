--
-- p o s i x . s y s . i o c t l
--
local ioctl = { }

local ffi 	= require('ffi')
local  C	=  ffi.C
local bit 	= require('bit')

ffi.cdef([[
enum {
	_IOC_NRBITS	= 8,
	_IOC_TYPEBITS	= 8,
	_IOC_SIZEBITS	= 14,
	_IOC_DIRBITS	= 2,
};
enum {
	_IOC_NRMASK	= (1 << _IOC_NRBITS)-1,
	_IOC_TYPE_MASK	= (1 << _IOC_TYPEBITS)-1,
	_IOC_SIZEMASK	= (1 << _IOC_SIZEBITS)-1,
	_IOC_DIRMASK	= (1 << _IOC_DIRBITS)-1,
};
enum {
	_IOC_NRSHIFT	= 0,
};
enum {
	_IOC_TYPESHIFT	= _IOC_NRSHIFT + _IOC_NRBITS,
	_IOC_SIZESHIFT	= _IOC_TYPESHIFT + _IOC_TYPEBITS,
	_IOC_DIRSHIFT	= _IOC_SIZESHIFT + _IOC_SIZEBITS,
};
enum {
	_IOC_NONE	= 0,
	_IOC_WRITE	= 1,
	_IOC_READ	= 2,
};
enum {
	IOC_IN		= _IOC_WRITE << _IOC_DIRSHIFT,
	IOC_OUT		= _IOC_READ << _IOC_DIRSHIFT,
	IOC_INOUT	= (_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT,
	IOCSIZE_MASK	= _IOC_SIZEMASK << _IOC_SIZESHIFT,
	IOCSIZE_SHIFT	= _IOC_SIZESHIFT,
};

int ioctl(int fd, unsigned long int req, ...);
]])

local byte = string.byte

function ioctl._IOC(dir, type, nr, size)
	return bit.bor(bit.lshift(dir,  C._IOC_DIRSHIFT),
			bit.lshift(byte(type), C._IOC_TYPESHIFT),
			bit.lshift(nr,   C._IOC_NRSHIFT),
			bit.lshift(size, C._IOC_SIZESHIFT))
end

function ioctl._IOC_TYPECHECK(t)
	return ffi.sizeof(t)
end

-- used to create numbers
function ioctl._IO(type, nr)
	return ioctl._IOC(C._IOC_NONE, type, nr, 0)
end
function ioctl._IOR(type, nr, size)
	return ioctl._IOC(C._IOC_READ, type, nr, ioctl._IOC_TYPECHECK(size))
end
function ioctl._IOW(type,nr,size)
	return ioctl._IOC(C._IOC_WRITE, type, nr, ioctl._IOC_TYPECHECK(size))
end
function ioctl._IOWR(type,nr,size)
	return ioctl._IOC(bit.bor(C._IOC_READ, C._IOC_WRITE),
			type, nr, ioctl._IOC_TYPECHECK(size))
end
function ioctl._IOR_BAD(type, nr, size)
	return ioctl._IOC(C._IOC_READ, type, nr, #size)
end
function ioctl._IOW_BAD(type, nr, size)
	return ioctl._IOC(C._IOC_WRITE, type, nr, #size)
end
function ioctl._IOWR_BAD(type,nr,size)
	return ioctl._IOC(bit.bor(C._IOC_READ, C._IOC_WRITE), type, nr,#size)
end

function ioctl._IOC_DIR(nr)
	return bit.band(bit.rshift(nr, C._IOC_DIRSHIFT), C._IOC_DIRMASK)
end
function ioctl._IOC_TYPE(nr)
	return bit.band(bit.rshift(nr, C._IOC_TYPESHIFT), C._IOC_TYPEMASK)
end
function ioctl._IOC_NR(nr)
	return bit.band(bit.rshift(nr, C._IOC_NRSHIFT), C._IOC_NRMASK)
end
function ioctl._IOC_SIZE(nr)
	return bit.band(bit.rshift(nr, C._IOC_SIZESHIFT), C._IOC_SIZEMASK)
end

return setmetatable(ioctl, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
