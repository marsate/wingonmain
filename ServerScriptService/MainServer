local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local MainStorage = ReplicatedStorage.MainStorage
local PlaceOrderEvent = MainStorage.Events.PlaceOrder
local GetOrdersFunction = MainStorage.Events.GetOrders
local ClaimOrderFunction = MainStorage.Events.ClaimOrder
local CompleteOrderEvent = MainStorage.Events.CompleteOrder

local OnOffDuty = MainStorage.Events.OnOffDuty
local AddPoints = MainStorage.Events.AddPoints
local AssignRoleEvent = MainStorage.Events.AssignRole

local PlayerJoin = require(script.Parent.ModulePull.Player:WaitForChild("PlayerHandleJoin"))
local PlayerHandleLeave = require(script.Parent.ModulePull.Player:WaitForChild("PlayerHandleLeave"))
local OnOffDutyHandler = require(script.Parent.ModulePull.Player:WaitForChild("OnOffDuty"))
local AssignRole = require(script.Parent.ModulePull.Player:WaitForChild("AssignRole"))

local PlayerCollisions = require(script.Parent.ModulePull.Character:WaitForChild("PlayerCollisions"))

local GivePoints = require(script.Parent.ModulePull.Points:WaitForChild("GiveAmount"))

local ChatListener = require(script.Parent.ModulePull.Commands:WaitForChild("ChatListener"))

local RunServiceServer = require(script.Parent.ModulePull.Map:WaitForChild("RunServiceServer"))
local ClickToBuy = require(script.Parent.ModulePull.Map:WaitForChild("ClickToBuy"))
local GameLeaderboards = require(script.Parent.ModulePull.Map:WaitForChild("GameLeaderboards"))
local MusicPlayer = require(script.Parent.ModulePull.Map:WaitForChild("MusicPlayer"))
local ServerShutdown = require(script.Parent.ModulePull.Map:WaitForChild("ServerShutdown"))

local PlaceOrder = require(script.Parent.ModulePull.POS:WaitForChild("PlaceOrder"))
local ClaimOrder = require(script.Parent.ModulePull.POS:WaitForChild("ClaimOrder"))
local MainOrders = require(script.Parent.ModulePull.POS.Storage:WaitForChild("MainOrders"))
local CompleteOrder = require(script.Parent.ModulePull.POS:WaitForChild("CompleteOrder"))

Players.PlayerAdded:Connect(function(Player)
	PlayerJoin.OnEventConnected(Player)

	Player.Chatted:Connect(function(Message)
		ChatListener.OnEventConnected(Player, Message)
	end)
end)

Players.PlayerRemoving:Connect(function(Player)
	PlayerHandleLeave.OnEventConnected(Player)
end)

PlaceOrderEvent.Event:Connect(function(Player, Order)
	PlaceOrder.OnEventConnected(Player, Order)
end)

CompleteOrderEvent.OnServerEvent:Connect(function(Player, OrderNumber, ItemsGive)
	CompleteOrder.OnEventConnected(Player, OrderNumber, ItemsGive)
end)

GetOrdersFunction.OnInvoke = function()
	return(MainOrders)
end

ClaimOrderFunction.OnInvoke = function(Player, OrderNumber)
	return ClaimOrder.OnEventConnected(Player, OrderNumber)
end

OnOffDuty.OnServerEvent:Connect(function(Player, Status)
	OnOffDutyHandler.OnEventConnected(Player, Status)
end)

AddPoints.Event:Connect(function(Player, Amount)
	GivePoints.OnEventConnected(Player, Amount)
end)

AssignRoleEvent.OnServerEvent:Connect(function(Player, Category, Role)
	AssignRole.OnEventConnected(Player, Category, Role)
end)

Workspace:FindFirstChild("BuyCar").Touched:Connect(function(TouchPart)
	if TouchPart.Parent:FindFirstChild("Humanoid") then
		ClickToBuy.TouchConnected(TouchPart.Parent)
	end
end)

Workspace:FindFirstChild("BuyCar").TouchEnded:Connect(function(TouchPart)
	if TouchPart.Parent:FindFirstChild("Humanoid") then
		ClickToBuy.TouchEnded(TouchPart.Parent)
	end
end)

game:BindToClose(function()
	ServerShutdown:init()
end)

RunServiceServer:init()
GameLeaderboards:init()
PlayerCollisions:init()
MusicPlayer:init()
