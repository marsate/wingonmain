local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local RunService = game:GetService("RunService")
local DataStoreService = game:GetService("DataStoreService")
local CollectionService = game:GetService("CollectionService")

local OrderedDataStorePoints = DataStoreService:GetOrderedDataStore("WingOnV22025PointsOrdered")
local OrderedDataStoreMoney = DataStoreService:GetOrderedDataStore("WingOnV22025MoneyOrdered")

local Routes = ReplicatedStorage:WaitForChild("Routes")

local RunServiceServer = {}

function RunServiceServer:init()
	local ElapsedTime = 0
	local CarElapsedTime = 0
	local MiddleElapsedTime = 0
	local MoneyElapsedTime = 0
	local TrafficElapsedTime = 0

	local Screens = Workspace.DriveScreens
	local CurrentPosition = 0

	local Car = Workspace.Car
	Car.PrimaryPart = Car:WaitForChild("Center")
	
	local ScreenModule = Workspace.CarUiModule
	local Middle = ScreenModule.Middle
	local One = ScreenModule.One
	local Two = ScreenModule.Two
	local BodyPosition = Middle.BodyPosition
	local MoveToOne = true

	RunService.Heartbeat:Connect(function(DeltaTime)
		ElapsedTime = ElapsedTime + DeltaTime
		CarElapsedTime = CarElapsedTime + DeltaTime
		MiddleElapsedTime = MiddleElapsedTime + DeltaTime
		MoneyElapsedTime = MoneyElapsedTime + DeltaTime
		TrafficElapsedTime = TrafficElapsedTime + DeltaTime

		if ElapsedTime >= 7 then
			for _, Descendant in pairs(Screens:GetDescendants()) do
				if Descendant:IsA("Frame") then
					Descendant:TweenPosition(UDim2.new(0, 0, CurrentPosition, 0), "Out", "Sine", 2, true)
				end
			end
			CurrentPosition = CurrentPosition - 1
			if CurrentPosition < -1 then
				CurrentPosition = 0
			end
			ElapsedTime = 0
		end

		if CarElapsedTime >= 0.01 then
			Car:SetPrimaryPartCFrame(Car.PrimaryPart.CFrame * CFrame.fromEulerAnglesXYZ(0.001, 0, 0))
			CarElapsedTime = 0
		end
		
		if MiddleElapsedTime >= 6 then
			if MoveToOne then
				BodyPosition.Position = One.Position
			else
				BodyPosition.Position = Two.Position
			end
			MoveToOne = not MoveToOne
			MiddleElapsedTime = 0
		end
		
		if MoneyElapsedTime >= 60 then
			MoneyElapsedTime = 0
			
			for i, Player in pairs(Players:GetChildren()) do
				Player:SetAttribute("Money", Player:GetAttribute("Money") + 100)
				Routes.patchData:FireClient(Player, {Money = Player:GetAttribute("Money")})
			end
			
			MoneyElapsedTime = 0
		end
		
		if TrafficElapsedTime >= 30 then
			TrafficElapsedTime = 0
			
			-- Reset
			for i, v in pairs(CollectionService:GetTagged("RedLight")) do
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(0, 0, 0)
				v.SurfaceLight.Enabled = false
			end
			
			-- Off Green
			
			for i, v in pairs(CollectionService:GetTagged("GreenLight")) do
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(0, 0, 0)
				v.SurfaceLight.Enabled = false
			end
			
			-- On Yellow
			
			for i, v in pairs(CollectionService:GetTagged("YellowLight")) do
				v.Material = Enum.Material.Neon
				v.Color = Color3.fromRGB(160, 160, 0)
				v.SurfaceLight.Enabled = true
			end
			
			task.wait(4)
			
			for i, v in pairs(CollectionService:GetTagged("RedLight")) do
				v.Material = Enum.Material.Neon
				v.Color = Color3.fromRGB(160, 0, 5)
				v.SurfaceLight.Enabled = true
			end
			
			for i, v in pairs(CollectionService:GetTagged("YellowLight")) do
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(0, 0, 0)
				v.SurfaceLight.Enabled = false
			end
			
			task.wait(10)
			
			for i, v in pairs(CollectionService:GetTagged("YellowLight")) do
				v.Material = Enum.Material.Neon
				v.Color = Color3.fromRGB(160, 160, 0)
				v.SurfaceLight.Enabled = true
			end
			
			task.wait(4)
			
			for i, v in pairs(CollectionService:GetTagged("YellowLight")) do
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(0, 0, 0)
				v.SurfaceLight.Enabled = false
			end
			
			for i, v in pairs(CollectionService:GetTagged("RedLight")) do
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(0, 0, 0)
				v.SurfaceLight.Enabled = false
			end

			for i, v in pairs(CollectionService:GetTagged("GreenLight")) do
				v.Material = Enum.Material.Neon
				v.Color = Color3.fromRGB(0, 160, 0)
				v.SurfaceLight.Enabled = true
			end
			
			TrafficElapsedTime = 0
		end

		workspace.FanBlades.FanBlades1.CFrame = workspace.FanBlades.FanBlades1.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, 0.1)
		workspace.FanBlades.FanBlades2.CFrame = workspace.FanBlades.FanBlades2.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, 0.1)
		workspace.FanBlades.FanBlades3.CFrame = workspace.FanBlades.FanBlades3.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, 0.1)
		workspace.FanBlades.FanBlades4.CFrame = workspace.FanBlades.FanBlades4.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, 0.1)
	end)
end

return RunServiceServer
