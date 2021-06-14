--
-- p o s i x . s t r i n g
--
local string = { }

local ffi	= require('ffi')

		  require('posix.sys.types')

ffi.cdef([[
void *memcpy (void *dest, const void *src, size_t n);
void *memmove (void *dest, const void *src, size_t n);
void *memccpy (void *dest, const void *src, int c, size_t n);
void *memset (void *s, int c, size_t n);
int memcmp (const void *s1, const void *s2, size_t n);
void *memchr (const void *s, int c, size_t n);

char *strcpy (char *dest, const char *src);
char *strncpy (char *dest, const char *src, size_t n);
char *strcat (char *dest, const char *src);
char *strncat (char *dest, const char *src, size_t n);
int strcmp (const char *s1, const char *s2);
int strncmp (const char *s1, const char *s2, size_t n);
int strcoll (const char *s1, const char *s2);
size_t strxfrm (char *dest, const char *src, size_t n);

char *strdup (const char *s);
char *strndup (const char *string, size_t n);
char *strchr (const char *s, int c);
char *strrchr (const char *s, int c);

size_t strcspn (const char *s, const char *reject);
size_t strspn (const char *s, const char *accept);
char *strpbrk (const char *s, const char *accept);
char *strstr (const char *haystack, const char *needle);
char *strtok (char *s, const char *delim);
char *strtok_r (char *s, const char *delim, char **save_ptr);
size_t strlen (const char *s);
size_t strnlen (const char *string, size_t maxlen);

char *strerror (int errnum);
int strerror_r (int errnum, char *buf, size_t buflen);
int strcasecmp (const char *s1, const char *s2);
int strncasecmp (const char *s1, const char *s2, size_t n);
char *strsep (char **stringp, const char *delim);
char *strsignal (int sig);
char *stpcpy (char *dest, const char *src);
char *stpncpy (char *dest, const char *src, size_t n);
]])

return string
