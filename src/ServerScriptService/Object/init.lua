Object = {}
Object.__index = Object

function Object.new(ObjectType,...)
	local ObjectModule = require(script[ObjectType])
	local NewObject = ObjectModule.new(...)
	
	NewObject.ObjectType = ObjectType
	
	return NewObject
end

return Object