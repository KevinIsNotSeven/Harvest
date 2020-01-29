local function UpdateBlock(x,z,Index,Value)
	local Patch = _G.root.patch_mod.patch
	
	Patch.Grid[x][z][Index] = Value
end

return UpdateBlock