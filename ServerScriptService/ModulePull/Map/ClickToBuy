local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events

local ClickToBuy = {}

function ClickToBuy.TouchConnected(Character)
	local Player = Players:GetPlayerFromCharacter(Character)
	EventsFolder.ClickToBuyClient:FireClient(Player, "Started")
end

function ClickToBuy.TouchEnded(Character)
	local Player = Players:GetPlayerFromCharacter(Character)
	EventsFolder.ClickToBuyClient:FireClient(Player, "Ended")
end

return ClickToBuy
