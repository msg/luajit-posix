#!/usr/bin/luajit

local stdio	= require('useful.stdio')
local  printf	=  stdio.printf
local  sprintf	=  stdio.sprintf
local strings	= require('useful.strings')

local template = [=[
--
-- p o s i x . e r r n o
--
local errno = { }

local ffi	= require('ffi')
local  C	=  ffi.C
ffi.cdef [[
enum {
%s
};
]]

return setmetatable(errno, {
	__index = function(t, n)
		t[n] = C[n]
		return t[n]
	end,
})
]=]

local entries = { }
local f = io.popen('errno -l')
for line in f:lines() do
	local fields = strings.split(line, ' ', 3)
	table.insert(entries, { name=fields[1], errno=tonumber(fields[2]) })
end
table.sort(entries, function(a,b) return a.errno < b.errno end)
local strs = { }
for _,entry in ipairs(entries) do
	local len8 = math.floor(#entry.name / 8)
	local tabs = string.rep('\t', 3-len8)
	entry = sprintf('\t%s%s= %d,', entry.name, tabs, entry.errno)
	table.insert(strs, entry)
end

f = io.open(arg[1], 'w')
f:write(sprintf(template, table.concat(strs, '\n')))
f:close()
