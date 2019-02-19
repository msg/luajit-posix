--
-- p o s i x . e r r n o
--
local errno = { }

errno.EPERM		= 1
errno.ENOENT		= 2
errno.ESRCH		= 3
errno.EINTR		= 4
errno.EIO		= 5
errno.ENXIO		= 6
errno.E2BIG		= 7
errno.ENOEXEC		= 8
errno.EBADF		= 9
errno.ECHILD		= 10
errno.EAGAIN		= 11
errno.ENOMEM		= 12
errno.EACCES		= 13
errno.EFAULT		= 14
errno.ENOTBLK		= 15
errno.EBUSY		= 16
errno.EEXIST		= 17
errno.EXDEV		= 18
errno.ENODEV		= 19
errno.ENOTDIR		= 20
errno.EISDIR		= 21
errno.EINVAL		= 22
errno.ENFILE		= 23
errno.EMFILE		= 24
errno.ENOTTY		= 25
errno.ETXTBSY		= 26
errno.EFBIG		= 27
errno.ENOSPC		= 28
errno.ESPIPE		= 29
errno.EROFS		= 30
errno.EMLINK		= 31
errno.EPIPE		= 32
errno.EDOM		= 33
errno.ERANGE		= 34
errno.EDEADLK		= 35
errno.ENAMETOOLONG	= 36
errno.ENOLCK		= 37
errno.ENOSYS		= 38
errno.ENOTEMPTY		= 39
errno.ELOOP		= 40
errno.EWOULDBLOCK	= errno.EAGAIN
errno.ENOMSG		= 42
errno.EIDRM		= 43
errno.ECHRNG		= 44
errno.EL2NSYNC		= 45
errno.EL3HLT		= 46
errno.EL3RST		= 47
errno.ELNRNG		= 48
errno.EUNATCH		= 49
errno.ENOCSI		= 50
errno.EL2HLT		= 51
errno.EBADE		= 52
errno.EBADR		= 53
errno.EXFULL		= 54
errno.ENOANO		= 55
errno.EBADRQC		= 56
errno.EBADSLT		= 57
errno.EDEADLOCK		= errno.EDEADLK
errno.EBFONT		= 59
errno.ENOSTR		= 60
errno.ENODATA		= 61
errno.ETIME		= 62
errno.ENOSR		= 63
errno.ENONET		= 64
errno.ENOPKG		= 65
errno.EREMOTE		= 66
errno.ENOLINK		= 67
errno.EADV		= 68
errno.ESRMNT		= 69
errno.ECOMM		= 70
errno.EPROTO		= 71
errno.EMULTIHOP		= 72
errno.EDOTDOT		= 73
errno.EBADMSG		= 74
errno.EOVERFLOW		= 75
errno.ENOTUNIQ		= 76
errno.EBADFD		= 77
errno.EREMCHG		= 78
errno.ELIBACC		= 79
errno.ELIBBAD		= 80
errno.ELIBSCN		= 81
errno.ELIBMAX		= 82
errno.ELIBEXEC		= 83
errno.EILSEQ		= 84
errno.ERESTART		= 85
errno.ESTRPIPE		= 86
errno.EUSERS		= 87
errno.ENOTSOCK		= 88
errno.EDESTADDRREQ	= 89
errno.EMSGSIZE		= 90
errno.EPROTOTYPE	= 91
errno.ENOPROTOOPT	= 92
errno.EPROTONOSUPPORT	= 93
errno.ESOCKTNOSUPPORT	= 94
errno.EOPNOTSUPP	= 95
errno.ENOTSUP		= errno.EOPNOTSUPP
errno.EPFNOSUPPORT	= 96
errno.EAFNOSUPPORT	= 97
errno.EADDRINUSE	= 98
errno.EADDRNOTAVAIL	= 99
errno.ENETDOWN		= 100
errno.ENETUNREACH	= 101
errno.ENETRESET		= 102
errno.ECONNABORTED	= 103
errno.ECONNRESET	= 104
errno.ENOBUFS		= 105
errno.EISCONN		= 106
errno.ENOTCONN		= 107
errno.ESHUTDOWN		= 108
errno.ETOOMANYREFS	= 109
errno.ETIMEDOUT		= 110
errno.ECONNREFUSED	= 111
errno.EHOSTDOWN		= 112
errno.EHOSTUNREACH	= 113
errno.EALREADY		= 114
errno.EINPROGRESS	= 115
errno.ESTALE		= 116
errno.EUCLEAN		= 117
errno.ENOTNAM		= 118
errno.ENAVAIL		= 119
errno.EISNAM		= 120
errno.EREMOTEIO		= 121
errno.EDQUOT		= 122
errno.ENOMEDIUM		= 123
errno.EMEDIUMTYPE	= 124
errno.ECANCELED		= 125
errno.ENOKEY		= 126
errno.EKEYEXPIRED	= 127
errno.EKEYREVOKED	= 128
errno.EKEYREJECTED	= 129
errno.EOWNERDEAD	= 130
errno.ENOTRECOVERABLE	= 131

return errno
