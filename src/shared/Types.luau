--!strict
local Types = {}

export type VersionInfo = {
	Major: number,
	Minor: number,
	Patch: number,
}

Types.GameVersion = { Major = 0, Minor = 1, Patch = 0 } :: VersionInfo

return Types
