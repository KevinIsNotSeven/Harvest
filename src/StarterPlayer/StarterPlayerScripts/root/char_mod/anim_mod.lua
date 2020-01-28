local anim_mod = {}

function anim_mod.New(char)
	local anim = {}
	for _,v in pairs(char.Pal.AnimationController:GetChildren())do
		anim[v.Name] = char.Pal.AnimationController:LoadAnimation(v)
	end
	return anim
end

return anim_mod