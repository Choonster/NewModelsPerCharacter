-- If set to true, new character models will be enabled by default. If set to false, they will be disabled by default.
local DEFAULT_ENABLED_STATE = true

-------------------
-- END OF CONFIG --
-------------------
-- Do not change anything below here!

local addon, ns = ...

local function UpdateModelsEnabled()
	SetCVar("hdPlayerModels", NEWCHARMODELS_ENABLED and 1 or 0)
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGOUT")

function f:ADDON_LOADED(name)
	if name == addon then
		if NEWCHARMODELS_ENABLED == nil then -- First time the AddOn has been loaded on this character, use the default enabled state.
			NEWCHARMODELS_ENABLED = DEFAULT_ENABLED_STATE
		end
		
		UpdateModelsEnabled()
	end
end

function f:PLAYER_LOGOUT() -- Restore the default setting when the player logs out
	SetCVar("hdPlayerModels", DEFAULT_ENABLED_STATE and 1 or 0)
end

SLASH_TOGGLENEWMODELS1, SLASH_TOGGLENEWMODELS2 = "/togglenewmodels", "/tnm"
SlashCmdList.TOGGLENEWMODELS = function()
	NEWCHARMODELS_ENABLED = not NEWCHARMODELS_ENABLED
	UpdateModelsEnabled()
	
	print(("New character models %s."):format(NEWCHARMODELS_ENABLED and "Enabled" or "Disabled"))
end