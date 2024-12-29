local config = require("ProjectCyrodiil.config")
local tamrielRebuiltConfig = include("TamrielRebuilt.config")
local skyrimConfig = include("SkyrimHomeOfTheNords.config")

if config.dataWarning == true and (not tamrielRebuiltConfig or not tamrielRebuiltConfig.dataWarning) and (not skyrimConfig or not skyrimConfig.dataWarning) then
	event.register(tes3.event.initialized, function()
		if tes3.isModActive("Cyr_Main.esm") and not tes3.getObject("T_Com_Res_WeaponResartus") then
				tes3ui.showNotifyMenu("Your copy of Tamriel_Data is too old for this version of Project Cyrodiil. Please install the latest version of Tamriel_Data, available on the Nexus or Tamriel Rebuilt's website, or severe problems will occur in-game.")
		end
	end)
end

-- Setup MCM
dofile("ProjectCyrodiil.mcm")