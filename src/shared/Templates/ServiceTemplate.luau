--!strict
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local ServiceTemplate = Knit.CreateService({
    Name = "ServiceTemplate", -- rename when you copy
    Client = {},
})

function ServiceTemplate:KnitInit()
    print("[" .. self.Name .. "] KnitInit")
end

function ServiceTemplate:KnitStart()
    print("[" .. self.Name .. "] KnitStart")
end

return ServiceTemplate