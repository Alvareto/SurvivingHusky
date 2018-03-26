function AddCurrentTime()
    local dlg = GetXDialog("HUD")
    if dlg['idCurrentTime'] then
        -- The current time is already there, so this must have been called more than once
        return
    end

    local left_buttons = dlg['idLeftButtons']
    local win = XWindow:new({}, left_buttons)

    XText:new({
        Id = "idCurrentTime", 
        MinWidth = 146, 
        RolloverTemplate = "Rollover", 
        HAlign = "right", 
        VAlign = "bottom", 
        TextFont = "BuildMenuBuilding", 
        TextColor = RGBA(255, 254, 171, 255), 
        RolloverTextColor = RGBA(255, 254, 171, 255), 
        Margins = box(150, 0, 0, 0), 
        TextHAlign = "center", 
        TextVAlign = "center"
    }, win)
    self.idCurrentTime:SetVisible(true)

    --[[ XText:new({
        Id = "idCurrentTime", 
        MinWidth = 146, 
        RolloverTemplate = "Rollover", 
        HAlign = "center", 
        VAlign = "center", 
        font_id = 8, --TextFont = "BuildMenuBuilding", 
        TextColor = RGBA(255, 254, 171, 255), 
        RolloverTextColor = RGBA(255, 254, 171, 255), 
        --// top left corner and dimensions
        Margins = box(41, 0, 0, 0), -- minx, miny, maxx, maxy TESTING TESTING TESTING- finally got it right
        -- GetXDialog("HUD")['idCurrentTime'].Margins = box(0, 0, 0, -25)
        TextHAlign = "center", 
        TextVAlign = "center"
    }, left_buttons)
    self.idCurrentTime:SetVisible(true)--]]

    local current_time = dlg['idCurrentTime']
    
    current_time:SetRolloverTitle(T{
        T{5778311, "Time"}, 
        UICity
    })
    current_time:SetRolloverText(T{
        T{
            "Current time is <em><time></em>", 
            time = function()
                return os.date("%H:%M")
            end
        }, 
        UICity
    })

    return current_time
end

function UpdateCurrentTime()
    if not UICity then
        return
    end
    local dlg = GetXDialog("HUD")
    local current_time = dlg['idCurrentTime']

    -- This shouldn't ever happen, but it can't hurt to check
    if not current_time then
        current_time = AddCurrentTime()
    end

    current_time:SetText(tostring(os.date("%H:%M")))

    -- init
    --[[self:CreateThread("update_clock", function()
        while UICity do
            local time = os.date("%H:%M")
            ModLog(tostring(GameTime()) .. " >TIME= " .. tostring(time))

            self.current_time:SetText(tostring(time))

            XUpdateRolloverWindow(current_time)

            Sleep(1000)
        end
    end)--]]
end

function OnMsg.UIReady()
    AddCurrentTime()
    UpdateCurrentTime()
end
function OnMsg.NewMinute()
    UpdateCurrentTime()
end

function OnMsg.LoadGame()
    -- This seems a little ridiculous, but it's the only way I've found to
    -- trigger when the UI is ready after loading a game
    CreateGameTimeThread(function()
        while true do
            WaitMsg("OnRender")
            if GetXDialog("HUD") then
                Msg("UIReady")
                break
            end
        end
    end)
end
function OnMsg.NewMapLoaded()
    Msg("UIReady")
end
