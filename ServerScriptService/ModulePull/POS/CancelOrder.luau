local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events

local MainOrders = require(script.Parent.Storage:WaitForChild("MainOrders"))

local OrderLog = require(script.Parent:WaitForChild("OrderLog"))
OrderLog.setupAPI("2675238445ed7fcb4cbc042e7f619208bac84d2580095c4aedc80d207c0b3d54", "673904e9c6dfd622dd614c8b")

local CancelOrder = {}

function CancelOrder.OnEventLeave(Player)
	for i,v in pairs(MainOrders) do
		if v["Player"] == Player.Name then
			OrderLog.setCancelled(v.UniqueOrderID)
			EventsFolder.StatusCancel:Fire(tonumber(i))
			EventsFolder.DeleteOnBoard:Fire(string.format("%03d", i))
			
			if v["Assembler"] then
				if Players:FindFirstChild(v["Assembler"]) then
					EventsFolder.NotificationRemote:FireClient(Players:WaitForChild(v.Assembler), {Text = "Order Cancelled", SubText = "There order you were preparing has been cancelled."})
					Players[v.Assembler].PlayerGui.OrderUi.Enabled = false
				end
			end
			
			MainOrders[i] = nil
		end
	end
end

return CancelOrder
