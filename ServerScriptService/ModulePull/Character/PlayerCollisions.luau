local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local PlayerCollisions = {}

function PlayerCollisions:init()
	PhysicsService:RegisterCollisionGroup("Characters")
	PhysicsService:CollisionGroupSetCollidable("Characters", "Characters", false)
end

return PlayerCollisions
