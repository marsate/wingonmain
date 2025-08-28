local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RoleSpawns = Workspace:WaitForChild("RoleSpawns")

local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events
local ModulesFolder = MainStorage.Modules
local PositionsFolder = MainStorage.Positions

local RoleInformation = require(ModulesFolder:WaitForChild("RoleInformation"))

local AssignRole = {}

function AssignRole.OnEventConnected(Player: Player, Role)
	local Character = Player.Character
	local CharacterHead = Character:WaitForChild("Head")
	
	if Role ~= "Management" then
		for i,v in pairs(CharacterHead.NameTag.Main.Icons:GetChildren()) do
			if v.Name == Role then
				v:Destroy()
			end
		end

		PositionsFolder:WaitForChild(Role).Value += 1
		EventsFolder.ProximityJob:FireClient(Player, Role)

		Player:SetAttribute("Role", Role)
		Character:MoveTo(RoleSpawns:WaitForChild(Role).Position)

		local NewIcon = Instance.new("ImageLabel")
		NewIcon.Image = "rbxassetid://"..RoleInformation[Role].NameTagIcon
		NewIcon.BackgroundTransparency = 1
		NewIcon.Name = Role
		NewIcon.Visible = true
		NewIcon.Parent = CharacterHead.NameTag.Main.Icons

		if Character:FindFirstChild("Shirt") then
			Character.Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id="..RoleInformation[Role].Uniform
		else
			local UniformPants = Instance.new("Shirt")
			UniformPants.Name = "Shirt"
			UniformPants.Parent = Character
			UniformPants.ShirtTemplate = "http://www.roblox.com/asset/?id="..RoleInformation[Role].Uniform
		end

		if Character:FindFirstChild("Pants") then
			Character.Pants.PantsTemplate = "rbxassetid://172393950"
		else
			local UniformPants = Instance.new("Pants")
			UniformPants.Name = "Pants"
			UniformPants.Parent = Character
			UniformPants.PantsTemplate = "rbxassetid://172393950"
		end
	else
		Character:MoveTo(RoleSpawns:WaitForChild(Role).Position)
	end
end

return AssignRole
