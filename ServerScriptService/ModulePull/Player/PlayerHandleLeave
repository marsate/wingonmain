local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")

local GlobalDataStore = DataStoreService:GetDataStore("WingOnV22025Data")
local OrderedDataStorePoints = DataStoreService:GetOrderedDataStore("WingOnV22025PointsOrdered")
local OrderedDataStoreMoney = DataStoreService:GetOrderedDataStore("WingOnV22025MoneyOrdered")

local SharedConnections = require(script.Parent.CentralConnection)
local CancelOrder = require(script.Parent.Parent.POS:WaitForChild("CancelOrder"))

local MainStorage = ReplicatedStorage.MainStorage
local PositionsFolder = MainStorage.Positions

local PlayerHandleLeave = {}

function PlayerHandleLeave.OnEventConnected(Player)
	if SharedConnections[Player] then
		CancelOrder.OnEventLeave(Player)
		
		local success, errorMessage = pcall(function()
			local dataToSave = {
				Points = Player:FindFirstChild("leaderstats") and Player.leaderstats:FindFirstChild("Points").Value or 0,
				Money = Player:GetAttribute("Money") or 0,
			}
			GlobalDataStore:SetAsync(Player.UserId, dataToSave)
			OrderedDataStorePoints:SetAsync(tostring(Player.UserId), Player.leaderstats:FindFirstChild("Points").Value)
			OrderedDataStoreMoney:SetAsync(tostring(Player.UserId), Player:GetAttribute("Money"))
		end)

		if not success then
			warn("Failed to save data for player "..Player.Name.. ": "..tostring(errorMessage))
		end
		
		for _, Connection in pairs(SharedConnections[Player]) do
			Connection:Disconnect()
		end
		
		SharedConnections[Player] = nil
	end
end

return PlayerHandleLeave
