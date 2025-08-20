--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local GameCoreController = Knit.CreateController { Name = "GameCoreController" }

local _serverUnix: number = 0
local _version: { Major: number, Minor: number, Patch: number }? = nil

function GameCoreController:GetServerUnix(): number
	return _serverUnix
end

function GameCoreController:GetVersion()
	return _version
end

function GameCoreController:KnitStart()
	local svc = Knit.GetService("GameCoreService")

	-- Listen server -> client
	svc.TimeSync:Connect(function(serverUnixTime: number)
		_serverUnix = serverUnixTime
		-- TODO: route to UI if needed
	end)

	svc.Version:Connect(function(v)
		_version = v
		-- TODO: route to UI if needed
	end)

	-- Kick off a lightweight ping (round-trip baseline)
	task.delay(1, function()
		svc.RequestPing:Fire("boot") -- validated length <= 32 on server
	end)
end

return GameCoreController
