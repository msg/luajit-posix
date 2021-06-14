--
-- p o s i x . t e r m i o s
--
local termios = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
enum {
	VINTR		= 0,
	VQUIT		= 1,
	VERASE		= 2,
	VKILL		= 3,
	VEOF		= 4,
	VTIME		= 5,
	VMIN		= 6,
	VSWTC		= 7,
	VSTART		= 8,
	VSTOP		= 9,
	VSUSP		= 10,
	VEOL		= 11,
	VREPRINT	= 12,
	VDISCARD	= 13,
	VWERASE		= 14,
	VLNEXT		= 15,
	VEOL2		= 16,
};

enum {
	IGNBRK	= 0000001,
	BRKINT	= 0000002,
	IGNPAR	= 0000004,
	PARMRK	= 0000010,
	INPCK	= 0000020,
	ISTRIP	= 0000040,
	INLCR	= 0000100,
	IGNCR	= 0000200,
	ICRNL	= 0000400,
	IUCLC	= 0001000,
	IXON	= 0002000,
	IXANY	= 0004000,
	IXOFF	= 0010000,
	IMAXBEL	= 0020000,
	IUTF8	= 0040000,
};

enum {
	OPOST	= 0000001,
	OLCUC	= 0000002,
	ONLCR	= 0000004,
	OCRNL	= 0000010,
	ONOCR	= 0000020,
	ONLRET	= 0000040,
	OFILL	= 0000100,
	OFDEL	= 0000200,
	VTDLY	= 0040000,
	VT0	= 0000000,
	VT1	= 0040000,
};

enum {
	 B0		= 0000000,
	 B50		= 0000001,
	 B75		= 0000002,
	 B110		= 0000003,
	 B134		= 0000004,
	 B150		= 0000005,
	 B200		= 0000006,
	 B300		= 0000007,
	 B600		= 0000010,
	 B1200		= 0000011,
	 B1800		= 0000012,
	 B2400		= 0000013,
	 B4800		= 0000014,
	 B9600		= 0000015,
	 B19200		= 0000016,
	 B38400		= 0000017,
	CSIZE		= 0000060,
	  CS5		= 0000000,
	  CS6		= 0000020,
	  CS7		= 0000040,
	  CS8		= 0000060,
	CSTOPB		= 0000100,
	CREAD		= 0000200,
	PARENB		= 0000400,
	PARODD		= 0001000,
	HUPCL		= 0002000,
	CLOCAL		= 0004000,
	 B57600		= 0010001,
	 B115200	= 0010002,
	 B230400	= 0010003,
	 B460800	= 0010004,
	 B500000	= 0010005,
	 B576000	= 0010006,
	 B921600	= 0010007,
	 B1000000	= 0010010,
	 B1152000	= 0010011,
	 B1500000	= 0010012,
	 B2000000	= 0010013,
	 B2500000	= 0010014,
	 B3000000	= 0010015,
	 B3500000	= 0010016,
	 B4000000	= 0010017,
	__MAX_BAUD	= B4000000,
};

enum {
	TCOOFF		= 0,
	TCOON		= 1,
	TCIOFF		= 2,
	TCION		= 3,

	TCIFLUSH	= 0,
	TCOFLUSH	= 1,
	TCIOFLUSH	= 2,

	TCSANOW		= 0,
	TCSADRAIN	= 1,
	TCSAFLUSH	= 2,
};

typedef unsigned char cc_t;
typedef unsigned int speed_t;
typedef unsigned int tcflag_t;
struct termios {
	tcflag_t c_iflag;
	tcflag_t c_oflag;
	tcflag_t c_cflag;
	tcflag_t c_lflag;
	cc_t c_line;
	cc_t c_cc[32];
	speed_t c_ispeed;
	speed_t c_ospeed;
};

speed_t cfgetospeed (const struct termios *termios_p);
speed_t cfgetispeed (const struct termios *termios_p);
int cfsetospeed (struct termios *termios_p, speed_t speed);
int cfsetispeed (struct termios *termios_p, speed_t speed);
int cfsetspeed (struct termios *termios_p, speed_t speed);
int tcgetattr (int fd, struct termios *termios_p);
int tcsetattr (int fd, int optional_actions, const struct termios *termios_p);
void cfmakeraw (struct termios *termios_p);
int tcsendbreak (int fd, int duration);
int tcdrain (int fd);
int tcflush (int fd, int queue_selector);
int tcflow (int fd, int action);
pid_t tcgetsid (int fd);

struct winsize {
	unsigned short ws_row;
	unsigned short ws_col;
	unsigned short ws_xpixel;
	unsigned short ws_ypixel;
};

]])

return setmetatable(termios, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
