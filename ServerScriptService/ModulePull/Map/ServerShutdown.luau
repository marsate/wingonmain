local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local ServerShutdown = {}

function ServerShutdown:init()
	for i, Player in pairs(Players:GetChildren()) do
		local PlayerGui = Player:WaitForChild("PlayerGui")
		local ShutdownUi = PlayerGui:WaitForChild("Shutdown")
		ShutdownUi.Enabled = true
		
		TweenService:Create(ShutdownUi.Content, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { GroupTransparency = 0}):Play()
	end
end

return ServerShutdown
