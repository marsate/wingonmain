local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events

local MainOrders = require(script.Parent.Storage:WaitForChild("MainOrders"))
local OrderLog = require(script.Parent:WaitForChild("OrderLog"))
OrderLog.setupAPI("2675238445ed7fcb4cbc042e7f619208bac84d2580095c4aedc80d207c0b3d54", "673904e9c6dfd622dd614c8b")

local PlaceOrder = {}

function PlaceOrder.OnEventConnected(Player, Order, Actor)
	MainOrders[Order.OrderNumber] = {}
	MainOrders[Order.OrderNumber]["Items"] = {}
	MainOrders[Order.OrderNumber].Type = Order["Type"]
	
	for i,v in pairs(Order.Items) do
		MainOrders[Order.OrderNumber]["Items"][i] = { ["Amount"] = Order.Items[i].Amount }
	end
	
	local OrderItems = {}

	for ItemName, ItemData in pairs(Order.Items) do
		for Amount = 1, ItemData.Amount do
			table.insert(OrderItems, ItemName)
		end
	end
	
	if not Actor then Actor = Player end
	
	MainOrders[Order.OrderNumber].UniqueOrderID = OrderLog.createOrder(Player, Actor, { items = OrderItems, status = "waiting_for_preparation", orderNumber = Order.OrderNumber }).id
	
	EventsFolder.PlaceOnBoard:Fire(Actor, Order)
	EventsFolder.StatusPrepare:Fire(tonumber(Order.OrderNumber))
	
	MainOrders[Order.OrderNumber].Actor = Actor.Name
	MainOrders[Order.OrderNumber].Player = Player.Name
	
	Players[Player.Name].PlayerGui.Recipt.MainFrame.Paper.OrderNumb.Text = string.format("%03d", Order.OrderNumber)
	
	for i,v in pairs(Players[Player.Name].PlayerGui.Recipt.MainFrame.Paper.ScrollingFrame:GetChildren()) do
		if v:IsA("TextLabel") and v.Name ~= "ItemName" then
			v:Destroy()
		end
	end
	
	for i,v in pairs(Order.Items) do
		local ItemNameTemplate = Players[Player.Name].PlayerGui.Recipt.MainFrame.Paper.ScrollingFrame.ItemName:Clone()
		ItemNameTemplate.Name = i
		ItemNameTemplate.Text = i
		ItemNameTemplate.Amount.Text = "x"..v.Amount
		ItemNameTemplate.Visible = true
		ItemNameTemplate.Parent = Players[Player.Name].PlayerGui.Recipt.MainFrame.Paper.ScrollingFrame
	end
	
	Players[Player.Name].PlayerGui.Recipt.Enabled = true
end

return PlaceOrder
