--
-- p o s i x . w o r d e x p
--
local wordexp = { }

local ffi		= require('ffi')
local  C		=  ffi.C
local  cast		=  ffi.cast
local  fstring		=  ffi.string
local  new		=  ffi.new


		  require('posix.sys.types')

ffi.cdef([[

enum {
	WRDE_DOOFFS = (1 << 0),
	WRDE_APPEND = (1 << 1),
	WRDE_NOCMD = (1 << 2),
	WRDE_REUSE = (1 << 3),
	WRDE_SHOWERR = (1 << 4),
	WRDE_UNDEF = (1 << 5),
	__WRDE_FLAGS = (WRDE_DOOFFS | WRDE_APPEND | WRDE_NOCMD
			| WRDE_REUSE | WRDE_SHOWERR | WRDE_UNDEF),
};

typedef struct {
	size_t we_wordc;
	char **we_wordv;
	size_t we_offs;
} wordexp_t;

enum {
	WRDE_NOSYS = -1,
	WRDE_NOSPACE = 1,
	WRDE_BADCHAR,
	WRDE_BADVAL,
	WRDE_CMDSUB,
	WRDE_SYNTAX
};

extern int wordexp (const char *words, wordexp_t *pwordexp, int flags);
extern void wordfree (wordexp_t *wordexp);
]])

wordexp.wordexp = function(s)
	local exp = { }
	local we = new('wordexp_t[1]')
	local p = cast('wordexp_t *', we)
	local rc = C.wordexp(s, p, 0)
	if rc ~= 0 then
		return nil, rc
	end
	local w = p.we_wordv
	for i=0,tonumber(p.we_wordc)-1 do
		table.insert(exp, fstring(w[i]))
	end
	C.wordfree(p)
	return exp
end


return wordexp
