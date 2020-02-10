local function UpdatePatch(x,z,Block)
	local Patch = _G.root.patch_mod.Grid
	
	Patch[x][z] = Block
end

return UpdatePatch