--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Validator = require(ReplicatedStorage.Shared.Modules.Validator)
local Types = require(ReplicatedStorage.Shared.Types)

local GameCoreService = Knit.CreateService({
	Name = "GameCoreService",
	Client = {
		-- Client -> Server
		RequestPing = Knit.CreateSignal(), -- (nonce: string<=32)
		-- Server -> Client
		TimeSync = Knit.CreateSignal(),    -- (serverUnixTime: number)
		Version = Knit.CreateSignal(),     -- (version: Types.VersionInfo)
	},
})

-- // Private
local _version: Types.VersionInfo = Types.GameVersion
local _heartbeatConnections: { [Player]: RBXScriptConnection } = {}

-- // Lifecycle
function GameCoreService:KnitInit()
	-- Client -> Server: RequestPing
	self.Client.RequestPing:Connect(function(player: Player, nonce: string)
		if not Validator.isPlayer(player) then return end
		if not Validator.isString(nonce, 32) then return end
		-- Respond with current server time (simple RTT baseline)
		self.Client.TimeSync:Fire(player, os.time())
	end)
end

function GameCoreService:KnitStart()
	-- Push version to joining players
	Players.PlayerAdded:Connect(function(p)
		self.Client.Version:Fire(p, _version)
		-- Optional: attach per-player heartbeat hooks later if needed
	end)

	for _, p in ipairs(Players:GetPlayers()) do
		self.Client.Version:Fire(p, _version)
	end
end

-- // Public (server-only) helpers for future systems
function GameCoreService:GetVersion(): Types.VersionInfo
	return _version
end

return GameCoreService
