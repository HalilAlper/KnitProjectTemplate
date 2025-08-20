--!strict
-- File: ReplicatedStorage/Shared/PackageLoader.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages") :: Folder

return function<T>(name: string): T
	local mod = Packages:FindFirstChild(name)
	if mod and mod:IsA("ModuleScript") then
		return require(mod) :: T
	end
	error(("Package '%s' not found in Packages"):format(name))
end
