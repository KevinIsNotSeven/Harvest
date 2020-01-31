local Object = require(script.Parent.Parent)
local Item = require(script.Parent)

local Tool = {}
Tool.__index = Tool
setmetatable(Tool,{__index = Item})

function Tool.new(ToolType,...)
	local Module = require(script[ToolType])
	local NewTool = Module.new(...)
	
	NewTool.ToolType = ToolType
	NewTool.ItemName = ToolType
	
	NewTool.Useable = true
	
	return NewTool
end

return Tool

