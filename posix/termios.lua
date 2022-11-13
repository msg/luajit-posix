--
-- p o s i x . t e r m i o s
--
local termios = { }

local ffi	= require('ffi')
local  C	=  ffi.C

		  require('posix.sys.types')

ffi.cdef([[
enum {
	IGNBRK	= 0000001, /* Ignore break condition.  */
	BRKINT	= 0000002, /* Signal interrupt on break.  */
	IGNPAR	= 0000004, /* Ignore characters with parity errors.  */
	PARMRK	= 0000010, /* Mark parity and framing errors.  */
	INPCK	= 0000020, /* Enable input parity check.  */
	ISTRIP	= 0000040, /* Strip 8th bit off characters.  */
	INLCR	= 0000100, /* Map NL to CR on input.  */
	IGNCR	= 0000200, /* Ignore CR.  */
	ICRNL	= 0000400, /* Map CR to NL on input.  */
	IUCLC	= 0001000, /* Map uppercase characters to lowercase on input
			(not in POSIX).  */
	IXON	= 0002000, /* Enable start/stop output control.  */
	IXANY	= 0004000, /* Enable any character to restart output.  */
	IXOFF	= 0010000, /* Enable start/stop input control.  */
	IMAXBEL	= 0020000, /* Ring bell when input queue is full
			(not in POSIX).  */
	IUTF8	= 0040000, /* Input is UTF8 (not in POSIX).  */
};

enum {
	OPOST	= 0000001, /* Post-process output.  */
	OLCUC	= 0000002, /* Map lowercase characters to uppercase on output.
			    (not in POSIX).  */
	ONLCR	= 0000004, /* Map NL to CR-NL on output.  */
	OCRNL	= 0000010, /* Map CR to NL on output.  */
	ONOCR	= 0000020, /* No CR output at column 0.  */
	ONLRET	= 0000040, /* NL performs CR function.  */
	OFILL	= 0000100, /* Use fill characters for delay.  */
	OFDEL	= 0000200, /* Fill is DEL.  */

	VTDLY	= 0040000, /* Select vertical-tab delays:  */
	  VT0	= 0000000, /* Vertical-tab delay type 0.  */
	  VT1	= 0040000, /* Vertical-tab delay type 1.  */
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
	ISIG	= 0000001,  /* Enable signals.  */
	ICANON	= 0000002,  /* Canonical input (erase and kill processing).  */
	ECHO	= 0000010,  /* Enable echo.  */
	ECHOE	= 0000020,  /* Echo erase character as error-correcting
			     backspace.  */
	ECHOK	= 0000040,  /* Echo KILL.  */
	ECHONL	= 0000100,  /* Echo NL.  */
	NOFLSH	= 0000200,  /* Disable flush after interrupt or quit.  */
	TOSTOP	= 0000400,  /* Send SIGTTOU for background output.  */
	IEXTEN	= 0100000,  /* Enable implementation-defined input
			     processing.  */
};

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
