--!strict
local RS = game:GetService("ReplicatedStorage")
local Load = require(RS.Shared.PackageLoader)
local Knit = Load("Knit")

-- Require all services you put in ServerScriptService/Services
for _, m in ipairs(script.Parent.Services:GetChildren()) do
	if m:IsA("ModuleScript") then
		require(m)
	end
end

Knit.Start():catch(warn)
