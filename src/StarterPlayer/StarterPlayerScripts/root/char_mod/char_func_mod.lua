local r = _G.root
return function(char)
	function char.Render()
		r.placing_mod.Render()
		r.ui_mod.Render()
		local cf = CFrame.new(char.pos)*char.toface
		char.Pal:SetPrimaryPartCFrame(cf)
		
		
		local cf = workspace.CurrentCamera.CFrame.p
		--cf = Vector3.new(math.floor(cf.X/4+.5)*4,math.floor(cf.Y/4+.5)*4,math.floor(cf.Z/4+.5)*4)
		cf = Vector3.new(cf.X,math.floor(cf.Y/40+.5)*40,cf.Z)
		--workspace.rain.CFrame = workspace.rain.CFrame*CFrame.Angles(0,.002,0) -workspace.rain.CFrame.p + cf
		--workspace.rain2.CFrame = workspace.rain2.CFrame*CFrame.Angles(0,-.0015,0) -workspace.rain2.CFrame.p + cf
		for _,v in pairs(workspace.rain:GetChildren())do
			v.OffsetStudsV = v.OffsetStudsV - .5
		end
		for _,v in pairs(workspace.rain2:GetChildren())do
			v.OffsetStudsV = v.OffsetStudsV - .6
		end
		char.RenderItem()
	end
	
	function char.Build()
		r.item_mod.inventory = r.as.Networking.NetworkingFunction:InvokeServer("GetPlayerInventory")

		for i,Item in pairs(r.item_mod.inventory) do
			if Item ~= "None" then
				r.item_mod.inventory[i] = r.item_mod.MakeItemObj(Item.ItemType,Item.ItemName)
			end
		end
		r.ui_mod.Breh()
	end
	
	function char.Jump()
		if char.Ground and not char.tojump then
			char.tojump = true
			char.vel = char.vel - r.gravity
		end
	end
	
	function char.UseItem()
		
	end

	function char.SellItem()
		r.as.Networking.NetworkingEvent:FireServer("SellItem",tostring(2))
	end

	function char.SelectItem()
		
	end

	function char.RenderItem()
		if r.item_mod.inventory["1"] ~= "None" then
			local Model = r.item_mod.inventory["1"].Model
			Model.Parent = workspace
			local origin = Model.Base.Origin.CFrame
			Model.Base.CFrame = char.Pal.Arm2R.CFrame*char.Pal.Arm2R.HandAttachment.CFrame * (origin-origin.p)*CFrame.new(-origin.p) --:Inverse()
		end
	end
end