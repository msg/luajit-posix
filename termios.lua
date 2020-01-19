--
-- p o s i x . t e r m i o s
--
local termios = { }

local ffi	= require('ffi')

require('posix.sys.types')

ffi.cdef([[
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

]])

termios.CBAUD			= tonumber(000000010017, 8)
termios.CBAUDEX			= tonumber(000000010000, 8)
termios.CIBAUD			= tonumber(002003600000, 8)
termios.CMSPAR			= tonumber(010000000000, 8)
termios.CRTSCTS			= tonumber(020000000000, 8)
termios.B57600			= tonumber(0010001, 8)
termios.B115200			= tonumber(0010002, 8)
termios.B230400			= tonumber(0010003, 8)
termios.B460800			= tonumber(0010004, 8)
termios.B500000			= tonumber(0010005, 8)
termios.B576000			= tonumber(0010006, 8)
termios.B921600			= tonumber(0010007, 8)
termios.B1000000		= tonumber(0010010, 8)
termios.B1152000		= tonumber(0010011, 8)
termios.B1500000		= tonumber(0010012, 8)
termios.B2000000		= tonumber(0010013, 8)
termios.B2500000		= tonumber(0010014, 8)
termios.B3000000		= tonumber(0010015, 8)
termios.B3500000		= tonumber(0010016, 8)
termios.B4000000		= tonumber(0010017, 8)
termios.VINTR			= 0
termios.VQUIT			= 1
termios.VERASE			= 2
termios.VKILL			= 3
termios.VEOF			= 4
termios.VTIME			= 5
termios.VMIN			= 6
termios.VSWTC			= 7
termios.VSTART			= 8
termios.VSTOP			= 9
termios.VSUSP			= 10
termios.VEOL			= 11
termios.VREPRINT		= 12
termios.VDISCARD		= 13
termios.VWERASE			= 14
termios.VLNEXT			= 15
termios.VEOL2			= 16
termios.CSIZE			= tonumber(0000060, 8)
termios.CS5			= tonumber(0000000, 8)
termios.CS6			= tonumber(0000020, 8)
termios.CS7			= tonumber(0000040, 8)
termios.CS8			= tonumber(0000060, 8)
termios.CSTOPB			= tonumber(0000100, 8)
termios.CREAD			= tonumber(0000200, 8)
termios.PARENB			= tonumber(0000400, 8)
termios.PARODD			= tonumber(0001000, 8)
termios.HUPCL			= tonumber(0002000, 8)
termios.CLOCAL			= tonumber(0004000, 8)
termios.IGNBRK			= tonumber(0000001, 8)
termios.BRKINT			= tonumber(0000002, 8)
termios.IGNPAR			= tonumber(0000004, 8)
termios.PARMRK			= tonumber(0000010, 8)
termios.INPCK			= tonumber(0000020, 8)
termios.ISTRIP			= tonumber(0000040, 8)
termios.INLCR			= tonumber(0000100, 8)
termios.IGNCR			= tonumber(0000200, 8)
termios.ICRNL			= tonumber(0000400, 8)
termios.IUCLC			= tonumber(0001000, 8)
termios.IXON			= tonumber(0002000, 8)
termios.IXANY			= tonumber(0004000, 8)
termios.IXOFF			= tonumber(0010000, 8)
termios.IMAXBEL			= tonumber(0020000, 8)
termios.IUTF8			= tonumber(0040000, 8)
termios.ISIG			= tonumber(0000001, 8)
termios.ICANON			= tonumber(0000002, 8)
termios.XCASE			= tonumber(0000004, 8)
termios.ECHO			= tonumber(0000010, 8)
termios.ECHOE			= tonumber(0000020, 8)
termios.ECHOK			= tonumber(0000040, 8)
termios.ECHONL			= tonumber(0000100, 8)
termios.NOFLSH			= tonumber(0000200, 8)
termios.TOSTOP			= tonumber(0000400, 8)
termios.ECHOCTL			= tonumber(0001000, 8)
termios.ECHOPRT			= tonumber(0002000, 8)
termios.ECHOKE			= tonumber(0004000, 8)
termios.FLUSHO			= tonumber(0010000, 8)
termios.PENDIN			= tonumber(0040000, 8)
termios.IEXTEN			= tonumber(0100000, 8)
termios.EXTPROC			= tonumber(0200000, 8)
termios.OPOST			= tonumber(0000001, 8)
termios.OLCUC			= tonumber(0000002, 8)
termios.ONLCR			= tonumber(0000004, 8)
termios.OCRNL			= tonumber(0000010, 8)
termios.ONOCR			= tonumber(0000020, 8)
termios.ONLRET			= tonumber(0000040, 8)
termios.OFILL			= tonumber(0000100, 8)
termios.OFDEL			= tonumber(0000200, 8)
termios.NLDLY			= tonumber(0000400, 8)
termios.NL0			= tonumber(0000000, 8)
termios.NL1			= tonumber(0000400, 8)
termios.CRDLY			= tonumber(0003000, 8)
termios.CR0			= tonumber(0000000, 8)
termios.CR1			= tonumber(0001000, 8)
termios.CR2			= tonumber(0002000, 8)
termios.CR3			= tonumber(0003000, 8)
termios.TABDLY			= tonumber(0014000, 8)
termios.TAB0			= tonumber(0000000, 8)
termios.TAB1			= tonumber(0004000, 8)
termios.TAB2			= tonumber(0010000, 8)
termios.TAB3			= tonumber(0014000, 8)
termios.BSDLY			= tonumber(0020000, 8)
termios.BS0			= tonumber(0000000, 8)
termios.BS1			= tonumber(0020000, 8)
termios.FFDLY			= tonumber(0100000, 8)
termios.FF0			= tonumber(0000000, 8)
termios.FF1			= tonumber(0100000, 8)
termios.VTDLY			= tonumber(0040000, 8)
termios.VT0			= tonumber(0000000, 8)
termios.VT1			= tonumber(0040000, 8)
termios.XTABS			= tonumber(0014000, 8)
termios.NCCS			= 32
termios.TCSANOW			= 0
termios.TCSADRAIN		= 1
termios.TCSAFLUSH		= 2
termios.B0			= tonumber(0000000, 8)
termios.B50			= tonumber(0000001, 8)
termios.B75			= tonumber(0000002, 8)
termios.B110			= tonumber(0000003, 8)
termios.B134			= tonumber(0000004, 8)
termios.B150			= tonumber(0000005, 8)
termios.B200			= tonumber(0000006, 8)
termios.B300			= tonumber(0000007, 8)
termios.B600			= tonumber(0000010, 8)
termios.B1200			= tonumber(0000011, 8)
termios.B1800			= tonumber(0000012, 8)
termios.B2400			= tonumber(0000013, 8)
termios.B4800			= tonumber(0000014, 8)
termios.B9600			= tonumber(0000015, 8)
termios.B19200			= tonumber(0000016, 8)
termios.B38400			= tonumber(0000017, 8)
termios.EXTA			= termios.B19200
termios.EXTB			= termios.B38400
termios.TIOCSER_TEMT		= 0x01
termios.TCOOFF			= 0
termios.TCOON			= 1
termios.TCIOFF			= 2
termios.TCION			= 3
termios.TCIFLUSH		= 0
termios.TCOFLUSH		= 1
termios.TCIOFLUSH		= 2

return termios
