--!strict
-- File: ServerScriptService/Services/TestService.luau
local Players = game:GetService("Players")

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

export type TestService = {
	Name: "TestService",
	Client: {
		Greeting: any, -- KnitSignal
		GetServerTime: (self: any, player: Player) -> number,
	},
}

local COOLDOWN = 0.5
local _lastCall: { [number]: number } = {}

local TestService: TestService = Knit.CreateService({
	Name = "TestService",
	Client = {
		Greeting = Knit.CreateSignal(),
	},
})

function TestService.Client:GetServerTime(player: Player): number
	local now = os.clock()
	local nextAllowed = _lastCall[player.UserId] or 0
	if now < nextAllowed then
		error("RATE_LIMIT") -- client should handle
	end
	_lastCall[player.UserId] = now + COOLDOWN
	return math.floor(now * 1000)
end

function TestService:KnitStart()
	-- Welcome ping to prove server→client signals work.
	local function greet(plr: Player)
		self.Client.Greeting:Fire(plr, { msg = "hello from server", when = os.time() })
	end
	for _, plr in ipairs(Players:GetPlayers()) do
		greet(plr)
	end
	Players.PlayerAdded:Connect(greet)
end

return TestService
