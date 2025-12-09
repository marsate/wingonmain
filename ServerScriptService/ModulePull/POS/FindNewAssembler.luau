local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local MainStorage = ReplicatedStorage.MainStorage
local EventsFolder = MainStorage.Events

local MainOrders = require(script.Parent.Storage:WaitForChild("MainOrders"))

local OrderLog = require(script.Parent:WaitForChild("OrderLog"))
OrderLog.setupAPI("2675238445ed7fcb4cbc042e7f619208bac84d2580095c4aedc80d207c0b3d54", "673904e9c6dfd622dd614c8b")

local FindNewAssembler = {}

function FindNewAssembler.OnEventReset(Player)
	for i,v in pairs(MainOrders) do
		if v["Assembler"] == Player.Name then
			OrderLog.setReprepare(v.UniqueOrderID)
			EventsFolder.NewAssembler:Fire(i)
			
			if v["Assembler"] then
				if Players:FindFirstChild(v["Assembler"]) then
					Players[v.Assembler].PlayerGui.OrderUi.Enabled = false
				end
			end
			
			if v["Player"] then
				if Players:FindFirstChild(v["Player"]) then
					EventsFolder.NotificationRemote:FireClient(Players:WaitForChild(v["Player"]), {Text = "Finding new assembler", SubText = "Your assembler has become unavailable. We will be finding a new one for you shortly."})
				end
			end
			
			v["Assembler"] = nil
		end
	end
end

return FindNewAssembler
