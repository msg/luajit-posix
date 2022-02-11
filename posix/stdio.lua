--
-- p o s i x . s t d i o
--
local stdio = { }

local ffi	= require('ffi')

		  require('posix.sys.types')

ffi.cdef([[
typedef struct _IO_FILE FILE;

FILE *fopen(const char *__restrict, const char *__restrict);
int fclose(FILE *);
int ferror(FILE *stream);
int fflush(FILE *stream);

int fprintf(FILE *__restrict, const char *__restrict, ...);
size_t fread(void *__restrict, size_t, size_t, FILE *__restrict);
size_t fwrite(const void *__restrict, size_t, size_t, FILE *__restrict);

int printf(const char *format, ...);
int sprintf(char *s, const char *format, ...);
int snprintf(char *s, size_t maxlen, const char *format, ...);
int perror(char *s);

int rename(const char *old, const char *new);
int renameat(int oldfd, const char *old, int newfd, const char *new);
int renameat2(int oldfd, const char *old, int newfd, const char *new, int flags);

enum {
	RENAME_NOREPLACE	= 1 << 0,
	RENAME_EXCHANGE		= 1 << 1,
	RENAME_WHITEOUT		= 1 << 2,
};

]])

return stdio
