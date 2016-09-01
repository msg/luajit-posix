--
-- p o s i x . i n i t
--
module(..., package.seeall)

local path = ... .. '.'
fcntl	= require(path .. 'fcntl')
netdb	= require(path .. 'netdb')
poll	= require(path .. 'poll')
stdio	= require(path .. 'stdio')
string	= require(path .. 'string')
time	= require(path .. 'time')
unistd	= require(path .. 'unistd')

arpa	= require(path .. 'arpa')
netinet	= require(path .. 'netinet')
--std	= require(path .. 'std')
