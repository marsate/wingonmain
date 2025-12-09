local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events
local FoodToolsFolder = MainStorage.FoodTools

local MainOrders = require(script.Parent.Storage:WaitForChild("MainOrders"))
local OrderLog = require(script.Parent:WaitForChild("OrderLog"))

local CompleteOrder = {}

function CompleteOrder.OnEventConnected(Player, OrderNumber, ItemsList)
	local AssemblerItems = ItemsList
	local CustomerItems = ItemsList
	
	EventsFolder.NotificationRemote:FireClient(Players:WaitForChild(MainOrders[tonumber(OrderNumber)].Player), {Text = "Order Completed", SubText = "Your order has been completed and should arrive shortly."})
	EventsFolder.StatusComplete:Fire(tonumber(OrderNumber))
	EventsFolder.DeleteOnBoard:Fire(string.format("%03d", OrderNumber))
	Players:WaitForChild(MainOrders[tonumber(OrderNumber)].Player).PlayerGui.Recipt.Enabled = false
	Players[MainOrders[tonumber(OrderNumber)].Assembler].PlayerGui.OrderUi.Enabled = false
	EventsFolder.AddPoints:Fire(Player, 3)
	OrderLog.setComplete(MainOrders[tonumber(OrderNumber)]["UniqueOrderID"])
	
	for ItemName, Amount in pairs(AssemblerItems) do
		local Backpack = Players:WaitForChild(MainOrders[tonumber(OrderNumber)].Assembler).Backpack
		
		for _, Item in ipairs(Backpack:GetChildren()) do
			if Item.Name == ItemName and Amount > 0 then
				Item:Destroy()
				Amount -= 1
			end
			if Amount == 0 then
				break
			end
		end
	end
	
	for ItemName, Amount in pairs(CustomerItems) do
		repeat 
			local NewItem = FoodToolsFolder:FindFirstChild(ItemName):Clone()
			NewItem.Parent = Players:WaitForChild(MainOrders[tonumber(OrderNumber)].Player).Backpack
			Amount -= 1
		until Amount == 0
	end
	
	MainOrders[tonumber(OrderNumber)] = nil
end

return CompleteOrder
