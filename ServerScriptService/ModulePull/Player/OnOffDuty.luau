local OnOffDuty = {}

function OnOffDuty.OnEventConnected(Player, Status)
	local Character = Player.Character
	local NameTag = Character.Head.NameTag
	
	if Status == "OnDuty" then
		if NameTag.Main.Icons:FindFirstChild("OffDuty") then NameTag.Main.Icons.OffDuty:Destroy() end
		local NewIcon = Instance.new("ImageLabel")
		NewIcon.Image = "rbxassetid://"..84351100879346
		NewIcon.BackgroundTransparency = 1
		NewIcon.Name = "OnDuty"
		NewIcon.Visible = true
		NewIcon.Parent = NameTag.Main.Icons
		
	elseif Status == "OffDuty" then
		if NameTag.Main.Icons:FindFirstChild("OnDuty") then NameTag.Main.Icons.OnDuty:Destroy() end
		local NewIcon = Instance.new("ImageLabel")
		NewIcon.Image = "rbxassetid://"..97125754598263
		NewIcon.BackgroundTransparency = 1
		NewIcon.Name = "OffDuty"
		NewIcon.Visible = true
		NewIcon.Parent = NameTag.Main.Icons
	end
end

return OnOffDuty
