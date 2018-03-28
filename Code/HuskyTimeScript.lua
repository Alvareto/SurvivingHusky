-- prop = Time, Date, Duration
function AddDateTimeDisplay(parent, prop, icon)
    XImage:new({
        Id = "idCurrent"..prop.."Icon", 
        Image = icon, 
        ImageScale = point(500, 500), 
    }, parent)
    local current = XText:new({
        Id = "idCurrent"..prop.."Display", 
        MinWidth = 25, 
        TextColor = RGB(255, 255, 255), 
        RolloverTextColor = RGB(255, 255, 255), 
    }, parent)
    return current
end


function AddCurrentTime()
    local interface = GetXDialog("InGameInterface")
    if interface['idTopRightTimeBar'] then
        -- The current time is already there, so this must have been called more than once
        return
    end

    --local this_mod_dir = GetModLocation()

    local bar = XWindow:new({
        Id = "idTopRightTimeBar", 
        HAlign = "right", 
        VAlign = "top", 
        LayoutMethod = "HList", 
        Margins = box(0, -1, 0, 0), 
        Padding = box(8, 0, 8, 0), 
        Background = RGBA(0, 20, 40, 200), 
        BorderWidth = 1, 
    }, interface)

    if interface['idTimeBar'] then
        -- The current time is already there, so this must have been called more than once
        return
    end
    
    local localtime_section = XWindow:new({
        Id = "idTimeBar", 
        LayoutMethod = "HList", 
        VAlign = "center", 
        HandleMouse = true, 
        RolloverTemplate = "Rollover", 
        Padding = box(0, 0, 5, 0), 
    }, bar)

    local current_time = AddDateTimeDisplay(localtime_section, "Time", "UI/Icons/res_experimental_research.tga")
    localtime_section:SetRolloverTitle(T{T{5778311, "Time"}, UICity})
    localtime_section:SetRolloverText(T{
        T{
            "Current time is <em><time></em>", 
            time = function()
                return tostring(os.date("%H:%M"))
            end
        }, 
        UICity
    })

    return current_time
end

function UpdateCurrentTime()
    local interface = GetXDialog("InGameInterface") -- ['idTopRightTimeBar']['idTimeBar']['idCurrentTimeDisplay']
    --local bar = interface['idTopRightTimeBar']
    --local section = bar['idTimeBar']
    --local current_time = section['idCurrentTimeDisplay']
    local current_time = interface['idCurrentTimeDisplay']

    -- This shouldn't ever happen, but it can't hurt to check
    if not current_time then
        current_time = AddCurrentTime()
    end

    current_time:SetText(tostring(os.date("%H:%M")))

    XUpdateRolloverWindow(section)
end

-- local function GetModLocation()
--     -- /Code/HuskyTimeScript.lua = 25
--     return debug.getinfo(2, "S").source:sub(2, -25)
-- end


function OnMsg.NewMinute()
    UpdateCurrentTime()
end

function OnMsg.UIReady()
    CreateGameTimeThread(function()
        while true do
            WaitMsg("OnRender")
            AddCurrentTime()
            UpdateCurrentTime()
            break
        end
    end)
end

function OnMsg.LoadGame()
    CreateGameTimeThread(function()
        while true do
            WaitMsg("OnRender")
            if GetXDialog("InGameInterface") then
                Msg("UIReady")
                break
            end
        end
    end)
end
function OnMsg.NewMapLoaded()
    Msg("UIReady")
end
