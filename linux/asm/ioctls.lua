--
-- l i n u x / a s m / i o c t l s . l u a
--
local ioctls = { }

local ffi		= require('ffi')
local  C		=  ffi.C

ffi.cdef([[
enum {
	TCGETS		= 0x5401,
	TCSETS		= 0x5402,
	TCSETSW		= 0x5403,
	TCSETSF		= 0x5404,
	TCGETA		= 0x5405,
	TCSETA		= 0x5406,
	TCSETAW		= 0x5407,
	TCSETAF		= 0x5408,
	TCSBRK		= 0x5409,
	TCXONC		= 0x540A,
	TCFLSH		= 0x540B,
	TIOCEXCL	= 0x540C,
	TIOCNXCL	= 0x540D,
	TIOCSCTTY	= 0x540E,
	TIOCGPGRP	= 0x540F,
	TIOCSPGRP	= 0x5410,
	TIOCOUTQ	= 0x5411,
	TIOCSTI		= 0x5412,
	TIOCGWINSZ	= 0x5413,
	TIOCSWINSZ	= 0x5414,
	TIOCMGET	= 0x5415,
	TIOCMBIS	= 0x5416,
	TIOCMBIC	= 0x5417,
	TIOCMSET	= 0x5418,
	TIOCGSOFTCAR	= 0x5419,
	TIOCSSOFTCAR	= 0x541A,
	FIONREAD	= 0x541B,
	TIOCINQ		= FIONREAD,
	TIOCLINUX	= 0x541C,
	TIOCCONS	= 0x541D,
	TIOCGSERIAL	= 0x541E,
	TIOCSSERIAL	= 0x541F,
	TIOCPKT		= 0x5420,
	FIONBIO		= 0x5421,
	TIOCNOTTY	= 0x5422,
	TIOCSETD	= 0x5423,
	TIOCGETD	= 0x5424,
	TCSBRKP		= 0x5425,
	TIOCSBRK	= 0x5427,
	TIOCCBRK	= 0x5428,
	TIOCGSID	= 0x5429,
	//TCGETS2		_IOR('T', = 0x2A, struct termios2)
	//TCSETS2		_IOW('T', = 0x2B, struct termios2)
	//TCSETSW2	_IOW('T', = 0x2C, struct termios2)
	//TCSETSF2	_IOW('T', = 0x2D, struct termios2)
	TIOCGRS485	= 0x542E,
	TIOCSRS485	= 0x542F,
	//TIOCGPTN	_IOR('T', = 0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
	//TIOCSPTLCK	_IOW('T', = 0x31, int)  /* Lock/unlock Pty */
	//TIOCGDEV	_IOR('T', = 0x32, unsigned int) /* Get primary device node of /dev/console */
	TCGETX		= 0x5432,
	TCSETX		= 0x5433,
	TCSETXF		= 0x5434,
	TCSETXW		= 0x5435,
	//TIOCSIG		_IOW('T', = 0x36, int)  /* pty: generate signal */
	TIOCVHANGUP	= 0x5437,
	//TIOCGPKT	_IOR('T', = 0x38, int) /* Get packet mode state */
	//TIOCGPTLCK	_IOR('T', = 0x39, int) /* Get Pty lock state */
	//TIOCGEXCL	_IOR('T', = 0x40, int) /* Get exclusive mode state */
	//TIOCGPTPEER	_IO('T', = 0x41) /* Safely open the slave */
	//TIOCGISO7816	_IOR('T', = 0x42, struct serial_iso7816)
	//TIOCSISO7816	_IOWR('T', = 0x43, struct serial_iso7816)

	FIONCLEX	= 0x5450,
	FIOCLEX		= 0x5451,
	FIOASYNC	= 0x5452,
	TIOCSERCONFIG	= 0x5453,
	TIOCSERGWILD	= 0x5454,
	TIOCSERSWILD	= 0x5455,
	TIOCGLCKTRMIOS	= 0x5456,
	TIOCSLCKTRMIOS	= 0x5457,
	TIOCSERGSTRUCT	= 0x5458,
	TIOCSERGETLSR   = 0x5459,
	TIOCSERGETMULTI = 0x545A,
	TIOCSERSETMULTI = 0x545B,

	TIOCMIWAIT	= 0x545C,
	TIOCGICOUNT	= 0x545D,

	FIOQSIZE	= 0x5460,

	TIOCPKT_DATA		=  0,
	TIOCPKT_FLUSHREAD	=  1,
	TIOCPKT_FLUSHWRITE	=  2,
	TIOCPKT_STOP		=  4,
	TIOCPKT_START		=  8,
	TIOCPKT_NOSTOP		= 16,
	TIOCPKT_DOSTOP		= 32,
	TIOCPKT_IOCTL		= 64,

	TIOCSER_TEMT	= 0x01,
}
]])

return ioctls
