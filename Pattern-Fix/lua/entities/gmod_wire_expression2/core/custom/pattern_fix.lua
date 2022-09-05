E2Lib.RegisterExtension("pattern_fix", true, "add timeout for findRE, replaceRE, match, matchFirst, gmatch")

require("pattern_fix")

local VarQuota = CreateConVar("pattern_fix", "0.1", FCVAR_ARCHIVE)

local function getQuota_ns(self)
	-- if isFullAccess(self.player) then return null end
	return VarQuota:GetFloat() * 1e9;
end

local gsub = CHADRegex.gsub
local find = CHADRegex.find

--- Returns the 1st occurrence of the string <pattern>, returns 0 if not found. Prints malformed string errors to the chat area.
e2function number string:findRE(string pattern)
	local OK, Ret = pcall(find, this, pattern, 1, false, getQuota_ns(self))
	if not OK then
		self.player:ChatPrint(Ret)
		return 0
	else
		return Ret or 0
	end
end

---  Returns the 1st occurrence of the string <pattern> starting at <start> and going to the end of the string, returns 0 if not found. Prints malformed string errors to the chat area.
e2function number string:findRE(string pattern, start)
	local OK, Ret = pcall(find, this, pattern, start, false, getQuota_ns(self))
	if not OK then
		self.player:ChatPrint(Ret)
		return 0
	else
		return Ret or 0
	end
end

---  Finds and replaces every occurrence of <pattern> with <new> using regular expressions. Prints malformed string errors to the chat area.
e2function string string:replaceRE(string pattern, string new)
	local OK, NewStr = pcall(gsub, this, pattern, new, nil, getQuota_ns(self))
	if not OK then
		self.player:ChatPrint(NewStr)
		return ""
	else
		return NewStr or ""
	end
end


local string_match = CHADRegex.match
local table_remove = table.remove

--- runs [[string.match]](<this>, <pattern>) and returns the sub-captures as an array. Prints malformed pattern errors to the chat area.
e2function array string:match(string pattern)
	local args = {pcall(string_match, this, pattern, nil, getQuota_ns(self))}
	if not args[1] then
		self.player:ChatPrint(args[2] or "Unknown error in str:match")
		return {}
	else
		table_remove( args, 1 ) -- Remove "OK" boolean
		return args or {}
	end
end

--- runs [[string.match]](<this>, <pattern>, <position>) and returns the sub-captures as an array. Prints malformed pattern errors to the chat area.
e2function array string:match(string pattern, position)
	local args = {pcall(string_match, this, pattern, position, getQuota_ns(self))}
	if not args[1] then
		self.player:ChatPrint(args[2] or "Unknown error in str:match")
		return {}
	else
		table_remove( args, 1 ) -- Remove "OK" boolean
		return args or {}
	end
end

local string_gmatch = CHADRegex.gmatch
local table_Copy = table.Copy
local Right = string.Right

-- Helper function for gmatch (below)
-- (By Divran)
local DEFAULT = {n={},ntypes={},s={},stypes={},size=0,istable=true,depth=0}
local function gmatch( self, this, pattern )
	local ret = table_Copy( DEFAULT )
	local num = 0
	local iter = string_gmatch( this, pattern, nil, getQuota_ns(self) )
	local v
	while true do
		v = {iter()}
		if (!v or #v==0) then break end
		num = num + 1
		ret.n[num] = v
		ret.ntypes[num] = "r"
	end
	self.prf = self.prf + num
	ret.size = num
	return ret
end

--- runs [[string.gmatch]](<this>, <pattern>) and returns the captures in an array in a table. Prints malformed pattern errors to the chat area.
-- (By Divran)
e2function table string:gmatch(string pattern)
	local OK, ret = pcall( gmatch, self, this, pattern )
	if (!OK) then
		self.player:ChatPrint( ret or "Unknown error in str:gmatch" )
		return table_Copy( DEFAULT )
	else
		return ret
	end
end

--- runs [[string.gmatch]](<this>, <pattern>, <position>) and returns the captures in an array in a table. Prints malformed pattern errors to the chat area.
-- (By Divran)
e2function table string:gmatch(string pattern, position)
	this = this:Right( -position-1 )
	local OK, ret = pcall( gmatch, self, this, pattern )
	if (!OK) then
		self.player:ChatPrint( ret or "Unknown error in str:gmatch" )
		return table_Copy( DEFAULT )
	else
		return ret
	end
end

--- runs [[string.match]](<this>, <pattern>) and returns the first match or an empty string if the match failed. Prints malformed pattern errors to the chat area.
e2function string string:matchFirst(string pattern)
	local OK, Ret = pcall(string_match, this, pattern, nil, getQuota_ns(self))
	if not OK then
		self.player:ChatPrint(Ret)
		return ""
	else
		return Ret or ""
	end
end

--- runs [[string.match]](<this>, <pattern>, <position>) and returns the first match or an empty string if the match failed. Prints malformed pattern errors to the chat area.
e2function string string:matchFirst(string pattern, position)
	local OK, Ret = pcall(string_match, this, pattern, position, getQuota_ns(self))
	if not OK then
		self.player:ChatPrint(Ret)
		return ""
	else
		return Ret or ""
	end
end
