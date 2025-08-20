--!strict
local Validator = {}

function Validator.isNumberInRange(value: any, min: number, max: number): boolean
	if typeof(value) ~= "number" then return false end
	return value >= min and value <= max
end

function Validator.isPlayer(value: any): boolean
	return typeof(value) == "Instance" and value:IsA("Player")
end

function Validator.isString(value: any, maxLen: number?): boolean
	if typeof(value) ~= "string" then return false end
	return not maxLen or #value <= maxLen
end

function Validator.isBoolean(value: any): boolean
	return typeof(value) == "boolean"
end

return Validator
