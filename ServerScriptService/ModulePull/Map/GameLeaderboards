local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local CollectionService = game:GetService("CollectionService")

local OrderedDataStorePoints = DataStoreService:GetOrderedDataStore("WingOnV22025PointsOrdered")
local OrderedDataStoreMoney = DataStoreService:GetOrderedDataStore("WingOnV22025MoneyOrdered")

local PointsLeaderboard = CollectionService:GetTagged("PointsLeaderboard")[1]
local MoneyLeaderboard = CollectionService:GetTagged("MoneyLeaderboard")[1]

local GameLeaderboards = {}

function GameLeaderboards:init()
	local DataStoreCooldown = false
	local LeaderboardRefreshTime = 60

	local function GetLeaderboardData(dataStore)
		if DataStoreCooldown then return nil end
		DataStoreCooldown = true

		local success, pages = pcall(function()
			return dataStore:GetSortedAsync(false, 10)
		end)

		if success then
			local data = pages:GetCurrentPage()
			DataStoreCooldown = false
			return data
		else
			task.wait(30)
			DataStoreCooldown = false
			return nil
		end
	end

	task.spawn(function()
		while true do
			local pointsData = GetLeaderboardData(OrderedDataStorePoints)
			task.wait(2)
			local moneyData = GetLeaderboardData(OrderedDataStoreMoney)

			if pointsData then
				for _, v in pairs(PointsLeaderboard.Screen.SurfaceGui.Frame.ScrollingFrame:GetChildren()) do
					if v:IsA("Frame") and v.Name ~= "Template" then
						v:Destroy()
					end
				end
				
				local sortedPoints = {}
				for _, Entry in ipairs(pointsData) do
					table.insert(sortedPoints, {key = Entry.key, value = tonumber(Entry.value)})
				end
				table.sort(sortedPoints, function(a, b) return a.value > b.value end)

				for index, Entry in ipairs(sortedPoints) do
					task.spawn(function()
						local success, username = pcall(Players.GetNameFromUserIdAsync, Players, Entry.key)
						if success then
							local UsernameTemplate = PointsLeaderboard.Screen.SurfaceGui.Frame.ScrollingFrame.Template:Clone()
							UsernameTemplate.Points.Text = tostring(Entry.value)
							UsernameTemplate.Username.Text = username
							UsernameTemplate.Name = tostring(Entry.value)
							UsernameTemplate.Visible = true

							UsernameTemplate.LayoutOrder = -Entry.value
							UsernameTemplate.Parent = PointsLeaderboard.Screen.SurfaceGui.Frame.ScrollingFrame
						end
					end)
				end
			end

			if moneyData then
				for _, v in pairs(MoneyLeaderboard.Screen.SurfaceGui.Frame.ScrollingFrame:GetChildren()) do
					if v:IsA("Frame") and v.Name ~= "Template" then
						v:Destroy()
					end
				end

				local sortedMoney = {}
				for _, Entry in ipairs(moneyData) do
					table.insert(sortedMoney, {key = Entry.key, value = tonumber(Entry.value)})
				end
				table.sort(sortedMoney, function(a, b) return a.value > b.value end)

				for index, Entry in ipairs(sortedMoney) do
					task.spawn(function()
						local success, username = pcall(Players.GetNameFromUserIdAsync, Players, Entry.key)
						if success then
							local UsernameTemplate = MoneyLeaderboard.Screen.SurfaceGui.Frame.ScrollingFrame.Template:Clone()
							UsernameTemplate.Points.Text = tostring(Entry.value)
							UsernameTemplate.Username.Text = username
							UsernameTemplate.Name = tostring(Entry.value)
							UsernameTemplate.Visible = true

							UsernameTemplate.LayoutOrder = -Entry.value
							UsernameTemplate.Parent = MoneyLeaderboard.Screen.SurfaceGui.Frame.ScrollingFrame
						end
					end)
				end
			end

			task.wait(LeaderboardRefreshTime)
		end
	end)
end

return GameLeaderboards
