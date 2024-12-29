local config = require("ProjectCyrodiil.config")

----------------------
-- MCM Template --
----------------------

local function registerModConfig()

    local template = mwse.mcm.createTemplate{name="Project Cyrodiil"}
    template:saveOnClose("ProjectCyrodiil", config)

    -- Preferences Page
    local preferences = template:createSideBarPage{label="Preferences"}

    -- Feature Toggles
    local toggles = preferences:createCategory{label = "Settings"}
    toggles:createOnOffButton{
        label = "Tamriel_Data Version Warning",
        description = "Provides a warning upon starting the game with Project Cyrodiil and an old version of Tamriel_Data.",
        variable = mwse.mcm.createTableVariable{
            id = "dataWarning",
            table = config,
        },
    }

    template:register()
end

event.register(tes3.event.modConfigReady, registerModConfig)