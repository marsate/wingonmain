local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events

local MainOrders = require(script.Parent.Storage:WaitForChild("MainOrders"))
local OrderLog = require(script.Parent:WaitForChild("OrderLog"))
OrderLog.setupAPI("2675238445ed7fcb4cbc042e7f619208bac84d2580095c4aedc80d207c0b3d54", "673904e9c6dfd622dd614c8b")

local ClaimOrder = {}

function ClaimOrder.OnEventConnected(Player, OrderNumber)
	if Player:GetAttribute("Role") == "Assembler" then
		for i,v in pairs(MainOrders) do
			if v["Assembler"] == Player.Name then
				return "Already has order"
			end
		end

		if not MainOrders[tonumber(OrderNumber)]["Assembler"] then
			if MainOrders[tonumber(OrderNumber)].Player ~= Player.Name then
				EventsFolder.ClaimOnBoard:Fire(Player.Name, OrderNumber)
				EventsFolder.NotificationRemote:FireClient(Players:WaitForChild(MainOrders[tonumber(OrderNumber)].Player), {Text = "Order in Preparation", SubText = "Your order is now being prepared by: "..Player.Name})
				MainOrders[tonumber(OrderNumber)]["Assembler"] = Player.Name
				OrderLog.setPreparing(MainOrders[tonumber(OrderNumber)]["UniqueOrderID"], Player)

				Players[Player.Name].PlayerGui.OrderUi.MainFrame.Paper.OrderNumb.Text = string.format("%03d", OrderNumber)
				Players[Player.Name].PlayerGui.OrderUi.MainFrame.Paper.Username.Text = MainOrders[tonumber(OrderNumber)].Actor
				
				Players[Player.Name].PlayerGui.OrderUi:SetAttribute("Type", MainOrders[tonumber(OrderNumber)]["Type"])
				Players[Player.Name].PlayerGui.OrderUi.Enabled = true
				EventsFolder.SetToCheck:FireClient(Players[Player.Name])

				for i,v in pairs(Players[Player.Name].PlayerGui.OrderUi.MainFrame.Paper.ScrollingFrame:GetChildren()) do
					if v:IsA("TextLabel") and v.Visible == true then
						v:Destroy()
					end
				end

				for i,v in pairs(MainOrders[tonumber(OrderNumber)].Items) do
					local ItemNameTemplate = Players[Player.Name].PlayerGui.OrderUi.MainFrame.Paper.ScrollingFrame.ItemName:Clone()
					ItemNameTemplate.Name = i
					ItemNameTemplate.Text = i
					ItemNameTemplate.Amount.Text = "x"..v.Amount
					ItemNameTemplate.Visible = true
					ItemNameTemplate.Parent = Players[Player.Name].PlayerGui.OrderUi.MainFrame.Paper.ScrollingFrame
				end

				return true
			else
				return "Same Player"
			end
		else
			return "Already Claimed"
		end
	else
		return "Not Assembler"
	end
end

return ClaimOrder
