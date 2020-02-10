local Object = require(script.Parent.Parent.Parent)
local Seed = require(script.Parent)

local Apple = {}
Apple.__index = Apple
setmetatable(Apple,{__index = Seed})

function Apple.new()
	local NewApple = {}
	setmetatable(NewApple,Apple)

	return NewApple
end

return Apple

