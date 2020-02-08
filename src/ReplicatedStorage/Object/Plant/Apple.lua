local Object = require(script.Parent.Parent)
local Plant = require(script.Parent)

local Apple = {}
Apple.__index = Apple
setmetatable(Apple,{__index = Plant})

function Apple.new()
	local NewApple = {}
	setmetatable(NewApple,Apple)
	
	return NewApple
end

return Apple

