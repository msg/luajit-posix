#!/usr/bin/luajit

local strings	= require('useful.strings')

local  format	=  string.format
local  join	=  table.concat

local template = [=[
--
-- p o s i x . e r r n o
--

-- auto-generated by: build_errno.lua

local errno = { }

local ffi	= require('ffi')
local  C	=  ffi.C
ffi.cdef [[
enum {
%s
};
]]

errno.names = {
%s
}

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
	local fields = { line:match('(%S+)%s+(%S+)%s(.*)') }
	table.insert(entries, { name=fields[1], errno=tonumber(fields[2]) })
end
table.sort(entries, function(a,b) return a.errno < b.errno end)
local enums = { }
local names = { }
local last = 0
for _,entry in ipairs(entries) do
	local len8 = math.floor(#entry.name / 8)
	local tabs = string.rep('\t', 3-len8)
	local enum = format('\t%s%s= %d,', entry.name, tabs, entry.errno)
	table.insert(enums, enum)
	local name
	if entry.errno == last then
		-- ignore
	else
		name = format('\t"%s",\t-- %d', entry.name, entry.errno)
		name = format('\t[%d] = "%s",\t-- %d',
				entry.errno, entry.name, entry.errno)
	end
	last = entry.errno
	table.insert(names, name)
end

if arg[1] == '-' then
	f = io.stdout
else
	f = io.open(arg[1], 'w')
end

f:write(format(template, join(enums, '\n'), join(names, '\n')))
