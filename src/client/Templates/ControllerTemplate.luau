--!strict
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local ControllerTemplate = Knit.CreateController({
    Name = "ControllerTemplate", -- rename when you copy
})

function ControllerTemplate:KnitInit()
    print("[" .. self.Name .. "] KnitInit")
end

function ControllerTemplate:KnitStart()
    print("[" .. self.Name .. "] KnitStart")
end

return ControllerTemplate
