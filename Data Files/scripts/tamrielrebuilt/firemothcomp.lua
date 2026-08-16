local core = require('openmw.core')

if core.API_REVISION < 39 then
    return
end

local storage = require('openmw.storage')
local l10n = core.l10n('TamrielRebuilt')
local menu_popup = nil
xpcall(
    function()
        menu_popup = require('scripts.TamrielData.utils.menu_popup')
    end,
    function()
        local ui = require('openmw.ui')
        ui.showMessage(string.format("%s", l10n("NoTamrielData_Warning")))
    end)
if not menu_popup then
    return
end

if core.contentFiles.has('TR_Mainland.esm') and not core.contentFiles.has('TR_Firemoth_remover.esp') then
    local miscSettings = storage.playerSection('Settings_TamrielRebuilt_Misc')

    if not miscSettings:get('FiremothComp') then
        return
    end
    local getActivePlugin = require('MWSE.mods.TamrielRebuilt.firemoth')
    local firemothPlugin = getActivePlugin(core.contentFiles.has)
    if firemothPlugin then
        menu_popup.popup(l10n('FiremothCompHeader'), l10n('FiremothCompWarning', { plugin = firemothPlugin }))
    end
end
