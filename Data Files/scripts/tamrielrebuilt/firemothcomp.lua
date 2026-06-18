local core = require('openmw.core')

if core.API_REVISION < 39 then
    return
end

local async = require('openmw.async')
local I = require('openmw.interfaces')
local storage = require('openmw.storage')
local ui = require('openmw.ui')
local util = require('openmw.util')

local function spacer(padding)
    if type(padding) == 'number' then
        padding = util.vector2(padding, padding)
    end
    return {
        props = {
            size = padding
        }
    }
end

local function okButton(events)
    local omwl10n = core.l10n('Interface')
    return {
        events = events,
        template = I.MWUI.templates.textNormal,
        props = {
            text = omwl10n('OK')
        }
    }
end

local function popup(title, message)
    local padding = util.vector2(5, 5)
    local width = util.vector2(380, 0)
    local element
    local function close()
        element:destroy()
    end
    element = ui.create({
        template = I.MWUI.templates.boxTransparent,
        layer = 'Popup',
        content = ui.content({
            {
                type = ui.TYPE.Container,
                props = {
                    relativePosition = util.vector2(1, 1),
                    size = width + padding * 2,
                },
                content = ui.content({
                    {
                        type = ui.TYPE.Flex,
                        props = {
                            position = padding
                        },
                        content = ui.content({
                            {
                                template = I.MWUI.templates.textParagraph,
                                props = {
                                    size = width,
                                    text = title,
                                    textAlignH = ui.ALIGNMENT.Center,
                                    textColor = I.MWUI.templates.textHeader.props.textColor
                                }
                            },
                            {
                                template = I.MWUI.templates.textParagraph,
                                props = {
                                    size = width,
                                    text = message
                                }
                            },
                            spacer(padding),
                            {
                                type = ui.TYPE.Flex,
                                props = {
                                    size = width,
                                    align = ui.ALIGNMENT.Center,
                                    arrange = ui.ALIGNMENT.Center,
                                },
                                content = ui.content({
                                    okButton({
                                        mouseClick = async:callback(close)
                                    })
                                })
                            },
                            spacer(padding)
                        })
                    }
                })
            }
        }),
        props = {
            anchor = util.vector2(0.5, 0.5),
            relativePosition = util.vector2(0.5, 0.5)
        }
    })
end

if core.contentFiles.has('TR_Mainland.esm') and not core.contentFiles.has('TR_Firemoth_remover.esp') then
    local miscSettings = storage.playerSection('Settings_TamrielRebuilt_Misc')
    
    if not miscSettings:get('FiremothComp') then
        return
    end
    local getActivePlugin = require('MWSE.mods.TamrielRebuilt.firemoth')
    local firemothPlugin = getActivePlugin(core.contentFiles.has)
    if firemothPlugin then
        local l10n = core.l10n('TamrielRebuilt')
        popup(l10n('FiremothCompHeader'), l10n('FiremothCompWarning', { plugin = firemothPlugin }))
    end
end
