local function UpdateBlock(x,z,Index,Value)
	local Patch = _G.root.patch_mod.Grid

	Patch[x][z][Index] = Value
end

return UpdateBlock