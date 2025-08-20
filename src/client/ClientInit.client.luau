--!strict
local RS = game:GetService("ReplicatedStorage")
local Load = require(RS.Shared.PackageLoader)
local Knit = Load("Knit")

-- Require all controllers you put in StarterPlayerScripts/Controllers
for _, m in ipairs(script.Parent.Controllers:GetChildren()) do
	if m:IsA("ModuleScript") then
		require(m)
	end
end

Knit.Start():catch(warn)
