--!strict
-- File: StarterPlayer/StarterPlayerScripts/Controllers/TestController.luau
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local TestController = Knit.CreateController({ Name = "TestController" })

function TestController:KnitStart()
	local TestService = Knit.GetService("TestService")

	-- Client→Server call (RemoteFunction under the hood)
	task.delay(1, function()
		local ok, result = pcall(function()
			return TestService:GetServerTime()
		end)
		if ok then
			print("[TestController] Server time (ms):", result)
		else
			warn("[TestController] GetServerTime failed:", result)
		end
	end)

	-- Server→Client signal (RemoteEvent under the hood)
	TestService.Greeting:Connect(function(payload)
		print("[TestController] Greeting:", payload.msg, "at", payload.when)
	end)
end

return TestController
