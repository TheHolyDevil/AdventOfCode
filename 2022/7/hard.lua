#!/usr/bin/env lua

--[[
-- 1 = inputreading
-- 2 = 
--]]

-- throw away line
io.read()

function traverse()
	local dirlisting = {}
	local cmd = io.read()
	while( true ) do
		-- read a line
		if(cmd == nil) then
			return dirlisting
		end
		if(string.sub(cmd, 1, 2) == "$ ") then
			cmd = string.sub(cmd, 3, -1)
		else
			print("ERROR: cmd does not start with '$ '")
			print(cmd)
		end
		if(string.sub(cmd, 1, 2) == "cd") then
			local arg = string.sub(cmd, 4, -1)
			if( arg == ".." ) then
				return dirlisting
			else
				dirlisting[arg] = {'d', traverse()}
			end
			cmd = io.read()
		elseif(string.sub(cmd, 1, 2) == "ls") then
			while(true) do
				cmd = io.read()
				if(cmd == nil or string.sub(cmd,1,1) == '$') then
					break
				end
				-- for now igore directory entries
				if(string.sub(cmd,1,1) ~= 'd') then
					local split = {}
					for str in string.gmatch(cmd, "%S+") do
						table.insert(split, str)
					end
					dirlisting[split[2]] = {'f', tonumber(split[1])}
				end
			end
		end
		-- this might be skipped in some cases (ls)
	end
end

-- schade das das nicht tut :(
--print(string.format("%*s", 5, ' '))

function visPrint(d, t)
	for k, v in pairs(t) do
		for i=1,d,1 do
			io.write(' ')
		end
		if( v[1] == 'f' ) then
			print(string.format("- %s (file, size=%d)", k, v[2]))
		else
			print(string.format("- %s (dir)", k))
			visPrint(d+2, v[2])
		end
	end
end

local lst = {}
lst['/'] = {'d', traverse()}

-- visitor printer
--visPrint(0, lst)

function visCount(t)
	local loc=0
	for k, v in pairs(t) do
		if( v[1] == 'f' ) then
			loc = loc + v[2]
		else
			loc = loc + visCount(v[2])
		end
	end
	return loc
end

-- used disk
used = visCount(lst)

total = 70000000
free = total - used
needed = 30000000
todo = needed - free

todomax = used

function visSmall(t)
	local loc=0
	for k, v in pairs(t) do
		if( v[1] == 'f' ) then
			loc = loc + v[2]
		else
			local foo = visSmall(v[2])
			loc = loc + foo
		end
	end
	if( loc >= todo and loc < todomax ) then
		todomax = loc
	end
	return loc
end

visSmall(lst)

print(todomax)
