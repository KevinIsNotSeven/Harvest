local r = _G.root
local patch_mod = {}
print("PATCH")

patch_mod.Grid = {}
setmetatable(patch_mod.Grid,{__index = function(_,x)
	patch_mod.Grid[x] = {}
	setmetatable(patch_mod.Grid[x],{__index = function(_,z)
		patch_mod.Grid[x][z] = {}
		return patch_mod.Grid[x][z]
	end})
	return patch_mod.Grid[x]
end})

return patch_mod