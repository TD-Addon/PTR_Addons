local config = require("SkyrimHomeOfTheNords.config")
local tamrielRebuiltConfig = include("TamrielRebuilt.config")

if config.dataWarning == true and (not tamrielRebuiltConfig or not tamrielRebuiltConfig.dataWarning) then
	event.register(tes3.event.initialized, function()
		if tes3.isModActive("Sky_Main.esm") and not tes3.getObject("T_Com_Res_WeaponResartus") then
				tes3ui.showNotifyMenu("Your copy of Tamriel_Data is too old for this version of Skyrim: Home of the Nords. Please install the latest version of Tamriel_Data, available on the Nexus or Tamriel Rebuilt's website, or severe problems will occur in-game.")
		end
	end)
end

-- Setup MCM
dofile("SkyrimHomeOfTheNords.mcm")