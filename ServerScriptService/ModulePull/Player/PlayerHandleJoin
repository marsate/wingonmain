local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

local DataStoreService = game:GetService("DataStoreService")
local MarketplaceService = game:GetService("MarketplaceService")
local PhysicsService = game:GetService("PhysicsService")

local StorageFolder = ReplicatedStorage.MainStorage
local Assets = StorageFolder.Assets
local Configuration = StorageFolder.Configuration
local EventsFolder = StorageFolder.Events
local PositionsFolder = StorageFolder.Positions

local GlobalDataStore = DataStoreService:GetDataStore("WingOnV22025Data")
local OrderedDataStorePoints = DataStoreService:GetOrderedDataStore("WingOnV22025PointsOrdered")
local OrderedDataStoreMoney = DataStoreService:GetOrderedDataStore("WingOnV22025MoneyOrdered")

local FindNewAssembler = require(script.Parent.Parent.POS:WaitForChild("FindNewAssembler"))
local SharedConnections = require(script.Parent.CentralConnection)

local PlayerHandleJoin = {}

function CreateNewData(Player)
	local DataTable = {Points = 0; Money = 0}

	local Success, Error = pcall(function()
		GlobalDataStore:SetAsync(Player.UserId, DataTable)
	end)

	if Success then
		return LoadData(Player)
	else
		warn(Error)
	end
end

function LoadData(Player)
	local Data

	local Success, Error = pcall(function()
		Data = GlobalDataStore:GetAsync(Player.UserId)
	end)

	if Success and Data then 
		return Data
	else
		return CreateNewData(Player)
	end
end

function OrderDataPoints(Player)
	local Data

	local Success, Error = pcall(function()
		Data = OrderedDataStorePoints:GetAsync(tostring(Player.UserId))
	end)

	if Success and Data then else
		local Success, Error = pcall(function()
			OrderedDataStorePoints:SetAsync(tostring(Player.UserId), Player.leaderstats.Points.Value or 0)
		end)

		if not Success then
			warn(Error)
		end
	end
end

function OrderDataMoney(Player)
	local Data

	local Success, Error = pcall(function()
		Data = OrderedDataStoreMoney:GetAsync(tostring(Player.UserId))
	end)

	if Success and Data then else
		local Success, Error = pcall(function()
			OrderedDataStoreMoney:SetAsync(tostring(Player.UserId), Player:GetAttribute("Money") or 0)
		end)

		if not Success then
			warn(Error)
		end
	end
end

function PlayerHandleJoin.OnEventConnected(Player)
	SharedConnections[Player] = {}
	
	if Player.Character then
		for _, Descendant in Player.Character:GetDescendants() do
			if Descendant:IsA("BasePart") then
				Descendant.CollisionGroup = "Characters"
			end
		end
	end
	
	SharedConnections[Player].CharacterAdded = Player.CharacterAdded:Connect(function(Character)
		local NameTag = Assets:WaitForChild("NameTag"):Clone()
		NameTag.Parent = Character.Head

		if Player:GetRankInGroup(Configuration.GroupID.Value) >= 50 then NameTag.Main.Icons:WaitForChild("M").Visible = true end
		if Player:GetRankInGroup(Configuration.GroupID.Value) == 140 or Player:GetRankInGroup(Configuration.GroupID.Value) == 240 or Player:GetRankInGroup(Configuration.GroupID.Value) == 255 then NameTag.Main.Icons:WaitForChild("D").Visible = true end
		if Player:GetRankInGroup(Configuration.GroupID.Value) >= 140 then NameTag.Main.Icons:WaitForChild("SHR").Visible = true Player.Team = Teams["Presidential Team"] end
		if Player:GetRankInGroup(Configuration.GroupID.Value) >= 100 and Player:GetRankInGroup(Configuration.GroupID.Value) <= 115 then NameTag.Main.Icons:WaitForChild("HR").Visible = true Player.Team = Teams["Corporate Team"] end
		if Player:GetRankInGroup(Configuration.GroupID.Value) >= 50 and Player:GetRankInGroup(Configuration.GroupID.Value) <= 70 then NameTag.Main.Icons:WaitForChild("HR").Visible = true Player.Team = Teams["Executive Team"] end
		if Player:GetRankInGroup(Configuration.GroupID.Value) >= 30 and Player:GetRankInGroup(Configuration.GroupID.Value) <= 45 then NameTag.Main.Icons:WaitForChild("MR").Visible = true Player.Team = Teams["Management Team"] end
		if Player:GetRankInGroup(Configuration.GroupID.Value) >= 10 and Player:GetRankInGroup(Configuration.GroupID.Value) <= 29 then NameTag.Main.Icons:WaitForChild("LR").Visible = true Player.Team = Teams["Staff Team"] end
		if Player:GetRankInGroup(Configuration.GroupID.Value) == 5 then NameTag.Main.Icons:WaitForChild("T").Visible = true end

		Player:SetAttribute("Role", nil)

		NameTag.Main.GroupRank.Text = Player:GetRoleInGroup(Configuration.GroupID.Value)
		NameTag.Main.GroupRank.TextColor3 = Player.TeamColor.Color
		NameTag.Main.Username.Text = Player.DisplayName.." (@"..Player.Name..")"

		Character.Humanoid.DisplayName = ""
		Character.Humanoid.NameOcclusion = 2
		Character.Humanoid.NameDisplayDistance = 0
		
		EventsFolder.ProximityJobRemove:FireClient(Player)

		if MarketplaceService:UserOwnsGamePassAsync(Player.UserId, 990562293) then
			local NewTool = StorageFolder.Gamepass.Segway:Clone()
			NewTool.Parent = Player.Backpack
		end
		
		for _, Descendant in Character:GetDescendants() do
			if Descendant:IsA("BasePart") then
				Descendant.CollisionGroup = "Characters"
			end
		end
	end)

	SharedConnections[Player].CharacterRemoving = Player.CharacterRemoving:Connect(function(Character)
		if Player:GetAttribute("Role") then PositionsFolder[Player:GetAttribute("Role")].Value -= 1 end
		FindNewAssembler.OnEventReset(Player)
		task.defer(Character.Destroy, Character)
	end)

	local Leaderstats = Player:FindFirstChild("leaderstats") or Instance.new("Folder")
	Leaderstats.Parent = Player
	Leaderstats.Name = "leaderstats"

	local Position = Instance.new("StringValue")
	Position.Parent = Leaderstats
	Position.Name = "Position"
	Position.Value = Player:GetRoleInGroup(Configuration.GroupID.Value)

	local Points = Instance.new("IntValue")
	Points.Parent = Leaderstats
	Points.Name = "Points"
	Points.Value = tonumber(LoadData(Player)["Points"])

	Player:SetAttribute("Money", tonumber(LoadData(Player)["Money"]))
	OrderDataPoints(Player)
	OrderDataMoney(Player)
end

return PlayerHandleJoin
