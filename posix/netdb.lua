--
-- p o s i x . n e t d b
--
local netdb = { }

local ffi	= require('ffi')
local  C	=  ffi.C

require('posix.sys.types')
require('posix.sys.socket')

ffi.cdef([[
enum {
	AI_PASSIVE	= 0x0001,
	AI_CANONNAME	= 0x0002,
	AI_NUMERICHOST	= 0x0004,
	AI_NUMERICSERV	= 0x0400,
	AI_V4MAPPED	= 0x0008,
	AI_ALL		= 0x0010,
	AI_ADDRCONFIG	= 0x0020,

	NI_NUMERICHOST	= 1,
	NI_NUMERICSERV	= 2,
	NI_NOFQDN	= 4,
	NI_NAMEREQD	= 8,
	NI_DGRAM	= 16,

	EAI_BADFLAGS	= -1,
	EAI_NONAME	= -2,
	EAI_AGAIN	= -3,
	EAI_FAIL	= -4,
	EAI_FAMILY	= -6,
	EAI_SOCKTYPE	= -7,
	EAI_SERVICE	= -8,
	EAI_MEMORY	= -10,
	EAI_SYSTEM	= -11,
	EAI_OVERFLOW	= -12,
};

struct hostent {
	char *h_name;
	char **h_aliases;
	int h_addrtype;
	int h_length;
	char **h_addr_list;
};
struct netent
{
	char *n_name;
	char **n_aliases;
	int n_addrtype;
	uint32_t n_net;
};
struct protoent
{
	char *p_name;
	char **p_aliases;
	int p_proto;
};
struct servent
{
	char *s_name;
	char **s_aliases;
	int s_port;
	char *s_proto;
};
struct addrinfo {
	int ai_flags;
	int ai_family;
	int ai_socktype;
	int ai_protocol;
	socklen_t ai_addrlen;
	struct sockaddr *ai_addr;
	char *ai_canonname;
	struct addrinfo *ai_next;
};
void endhostent (void);
void endnetent (void);
void endprotoent (void);
void endservent (void);
void freeaddrinfo (struct addrinfo *ai);
const char *gai_strerror (int __ecode);
int getaddrinfo (const char *name, const char *service,
		const struct addrinfo *req, struct addrinfo **pai);
struct hostent *gethostbyname(const char *name);
struct hostent *gethostbyaddr(const void *addr, socklen_t len, int type);
struct hostent *gethostent (void);
int getnameinfo (const struct sockaddr *sa,
	socklen_t salen, char *host, socklen_t hostlen, char *serv,
	socklen_t servlen, int flags);
struct netent *getnetbyaddr (uint32_t net, int type);
struct netent *getnetbyname (const char *name);
struct netent *getnetent (void);
struct protoent *getprotobyname (const char *name);
struct protoent *getprotobynumber (int proto);
struct protoent *getprotoent (void);
struct servent *getservbyname (const char *name, const char *proto);
struct servent *getservbyport (int port, const char *proto);
struct servent *getservent (void);
void sethostent (int stay_open);
void setnetent (int stay_open);
void setprotoent (int stay_open);
void setservent (int stay_open);
]])

return setmetatable(netdb, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
