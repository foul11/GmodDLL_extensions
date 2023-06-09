```lua
local string = CHADRegex

string.gmatch(string,   pattern,                                   callback or timeOutNS = nil, everySimpleStep = 1e5)
string.gsub  (string,   pattern, replacement, maxReplaces = nil,   callback or timeOutNS = nil, everySimpleStep = 1e5)
string.match (string,   pattern, startPos = 1,                     callback or timeOutNS = nil, everySimpleStep = 1e5)
string.find  (haystack, needle,  startPos = 1, noPatterns = false, callback or timeOutNS = nil, everySimpleStep = 1e5)

callback(SimpleStepCount)
	return true -- stop?
end
```