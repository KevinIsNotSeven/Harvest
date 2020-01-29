local function UpdatePatch(x,z,Block)
	local Patch = _G.root.patch_mod.patch
	
	Patch.Grid[x][z] = Block
end

return UpdatePatch