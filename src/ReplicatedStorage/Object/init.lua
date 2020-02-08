Object = {}
Object.__index = Object

Object.ReplicatedStorage = game:GetService("ReplicatedStorage")
Object.NetworkingEvent = Object.ReplicatedStorage.Networking.NetworkingEvent
Object.NetworkingFunction = Object.ReplicatedStorage.Networking.NetworkingFunction

function Object.new(ObjectType,...)
	local ObjectModule = require(script[ObjectType])
	local NewObject = ObjectModule.new(...)
	
	NewObject.ObjectType = ObjectType
	
	return NewObject
end

function Object:Destroy()
	self = nil
end
---
return Object

