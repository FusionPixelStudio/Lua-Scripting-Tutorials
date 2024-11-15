
local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)

local projectManager = resolve:GetProjectManager()
local project = projectManager:GetCurrentProject()
local mediaPool = project:GetMediaPool()
local timeline = project:GetCurrentTimeline()
local video_clips = timeline:GetItemListInTrack("video", 1)
local audio_clips = timeline:GetItemListInTrack("audio", 1)

local logoB64 = [[data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAAAyCAYAAADsg90UAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxMAAAsTAQCanBgAAAhfSURBVGhD1Zp5jBRFFMbZ5ZBTcA0iKIqAiIAcYgAR8ECJRwRRQEBAE64E5ZBb/iCioFHxQozgLSEioHL9wS3IIqdyg8ppEJBDwAjLDevvq3k7Tu/s7szO9CzDl3zzql5Vvfeqprq6urpTCiUhLl26VBHxAGwK68Jb4LUpKSnFMzMzz5M+BvfCrXAVXETZbphJ+soEHStCx9vBxfACeQel4WG4hezPyE1wPzwfqOHqCOthb1jKTF4ZIP5Ugu4Id4R0ZgMcBe9FVdaqeoC+JGxIncFwGXQDgjwE+5EsZlWTFwR6I5xvgZ+Dk2EDK84XMFGFtu/BDLOnmRKTrQIBwbWEf1uw+gfvsKK4gJ1K8BsonMF8LytKHhBYV6h/XNf3CIL0fTHGbgd43Ab4tdx8FPhdgGC6IT6Hp2AXOB9Wg37jT3gTnMvdoTID8HpqauoIV3I5QABa7EZC4ST5ZtKTnkHad2D3D7N/s9JQ6CldgQPHpYhpmgWmad/ailT2PryYAC4xF/JRG/4LtSbUN3XBAKda6deq8wLpMVZUoMB1e3wLG0gXNXVigbMm8KDrOSC9CVHEigsc+J9icfQzVeKAky7wNDwOM6BwvxVfFuBfs/EU1M6yhHS+3wUY4MKIMcihyO3wNVbhr8gvZRUOGwAC6YF4LpDzD/hcDodbNgj8vY1+IPH0IZ6PTO0PMF4GzsK4ptkCRDnkp5ZvY9U8QJ+u8gTgH3PhAf6qQS3EWpdSfJsBGKsKZ5KsA8czyi+S1/V+EJ4nXwleIO0BdarAlpb1E+v5h9dZ2gM6vwLRiHiqBjRxAoPN4RF4FgbvtaQb0Tn9+5NNlRQgnsEWV+9U08UMjOgaXqwkfJhR/0R6QxP9MNLLXC55kBVPk5gvAQawCBxL5/ojt6BqTef3BEoDYHAmUt6L8saUrTG1B5Q1g20t6xvwuwpOt6wHxKUzgxNwrVPkFxhIg/MIXNNoNixjRR6gnwuF60wVBspWyI7fwG6GucgRlP8FD+Z7BtCoBmIOrM4Iv4UcgdT0DwN1VyPuorwEPBfQekGsD8IOlvUN+FsBv7RsGIhtE6JmIBclaNQKamOjDU5XU+cK6qyDYSt/MoC43PbcsnmDeik06KvOwAOwsRXlCeqtgBdpX9xUSQPi2gpPR7wECL4Y1H29J1L31TYsaPsCpXkDB7pUHoOVabPfKbOBOo0QwadDH7EGn7MtHQb8HkWcDuRyAZXK0+mlUJhG3u2fowX1x6khsrmpwkBZgS+ClKVZnfRcZwCFtRH6B6vAUcyAV2C+zt2x0ZM2H+NrIP/Gu6b2gDqPIjoFcr7iJ3xOsLQHxHMfYgky52cBgnoc6gDhBJXamzrfoH0d2rtbpamSAoT0ssX1jKkCQKdjq2FQJyp74Z1WFBOwVxgb+6AGsqSpLyusj1oAtW1PC14CZHR9T2DKdqPSStJtmUKHXGEcwO6b2ByCzR7Y+8zUQVCuTVJUd5V8Yhv+dlk6COJoCLUDXER5K6ckiIpwJQWaFpPgVa7AB2CrBtSM2oj5sGcP9Ivl129gV6t8GNB/bVXcpa37u6b5LKgXki/xb2l/7+tLRnzMwOYTOO3MqE8xtQNlQxCJOK1Nx1d3Szvgvz78heQO4qkFLymAbRoOgXToqWpuPAM3Q53m6k4REaoHz8N9uMnxXV+igV+tR+7wBdnO1C64jVDQwhANt0MdL8uQdoYfwoiXDHXesDaagjE/hcYK/A41/3ND/esS2IisyXSJ+rrHgN7TaxS1P9BJ0EJka3gmUCMc+NEiu5I69agf3BegT0M0QO/roODjd3zo7ZB8PILQnkbfFTRA//+uVAMAzypNo7JQ10lE0qYCLAUXkdfIjncG8wB1dB6nkyNdSs+aTmeHvgO7h81+U3gC6rYXdvTmmQGkB5Ae5EoiYyZt+uJLg7aevN7D1UOnrzZyBT701cc8qH3BMJOJeIObDrXgiprd3YltEtILDQB0MyBW0L6Ljfo4U+UJ6t0Nj1gbrQm+LozYK4bdV2HWou3d8YUg+wx4knS0+/JltPlACRyWhrrv/oaunnSRgK/qiO+49OvSVtfkENJTYY6HK9EAm/qnH4KjsaO15gDpjsSk2ZAjsg+AjrRzfXILBQ42w+VK4ygF7iFfTnQVogBt9Kitd4X9aVeUtM4Wx8LviUdndhEhG4gWSG1s2mPnGtLax+g88AXsHEHmCs8A0E7/5A2Boog4Qhutqg7Y2Ym4Hl3pgCZ60Fb7idGwDR3QYOrbAX038APU+rIbHsP2Wco0UBrk26GO0jrQpDzSgTJ9NTaKulpnIkMDAN0agNQHR0ej5ERnwEB+Jzxp2ZhA8DWx8Q7cS9oDdB6Y2oGs7ixfwHvMVPSgUdyLoICNuAcgC/RJT2y1YB8YfLWeBXS6rU2Fg2BjVDG/7s6+BmhP3seVRMZc2gQ/OaFtzJdAKOhMKtRapGu6E9PbfT6DToO7EGqhnAN1mcSN7ANQAcNRfa1FQLtoE3wREs8AYEu7wNtgR9KdkTpy11qgmalOTyE7069OhyL7AFQmrU9To8Fu2vxq6XwPgDoN9Y7hKfg0nXN+0Wk7vZT8VOQs5HHpE4XsA6DHx2gfTRfQZqSloxoA67R2jHqO0OakPh2UTt//6l49DU7HRvDuknBoAGBCF0H0+jJjAFwN9Z5AC5meJNPh8zB4Gytw4Dz0YWg4aQUWkdT1vHZC5xkA0jpl0ir+Iwzt9EqowahkVS8rsl8C2kpe7UoigJmbAYOLEm11CahTfaEWshaU6w1yJnIdYjpSi5k+c08auAEgKO3H4zoGw0bweR5T2s9vg1rIpjC4YYeTyQINwLfIWwPZuKADT70FnswA6J/eDn09W/QfhQr9B0I/WozkP9HUAAAAAElFTkSuQmCC]]

local TITLE_CSS = [[
    QLabel
    {
        color: rgb(255, 255, 255);
        font-size: 30px;
        font-weight: bold;
    }
]]

local BUTTON_CSS = [[
    QPushButton
    {
        border: 1px solid #141414;
        max-height: 28px;
        border-radius: 14px;
        background-color: #2c473d;
        color: #ffffff;
        min-height: 28px;
        font-size: 13px;
        font-family: Readex Pro;
        font-weight: 600;
        letter-spacing: 1px;
    }
    QPushButton:hover
    {
        border: 2px solid rgb(50,50,50);
        background-color: #1b2e26;
    }
    QPushButton:pressed
    {
        border: 2px solid rgb(0,0,0);
        background-color: rgb(0,0,0);
    }
]]

function LinkClick(ev)
    bmd.openurl(ev.URL)
end

local function ConvertFrameToTimecode(frame, fps)
    local rounded_fps = math.floor(fps + 0.5)

    local frame_count = math.fmod(frame, rounded_fps)
    local seconds = math.fmod(math.floor(frame / rounded_fps), 60)
    local minutes = math.fmod(math.floor(math.floor(frame / rounded_fps) / 60), 60)
    local hours = math.floor(math.floor(math.floor(frame / rounded_fps) / 60) / 60)

    local frame_chars = string.len(tostring(rounded_fps - 1))
    local frame_divider = ":"

    local format_string = "%02d:%02d:%02d" .. frame_divider .. "%0" .. frame_chars .. "d"

    return string.format(format_string, hours, minutes, seconds, frame_count)
end

local function GetTimelineClipFromMediaPool(timeline_name, folder)
    local folder = folder or mediaPool:GetRootFolder()

    for i, clip in ipairs(folder:GetClipList()) do
        if clip:GetClipProperty("Type") == "Timeline" and
                clip:GetClipProperty("Clip Name") == timeline_name then
            return clip
        end
    end

    for _, subfolder in ipairs(folder:GetSubFolderList()) do
        local clip = GetTimelineClipFromMediaPool(timeline_name, subfolder)
        if clip ~= nil then
            return clip
        end
    end

    return nil
end

-- local monitorTimer = ui:Timer{ ID = "testTimer", Interval = 100, SingleShot = false }

-- page_monitor_func = function()
--     local current_page = resolve:GetCurrentPage()
   
--     return function(ev)
--         changed_page = resolve:GetCurrentPage()
--         if changed_page == nil then
--             print('Page Changed nil. Stop monitoring page changes.')
--             monitorTimer:Stop()
--             disp:ExitLoop()
--         elseif current_page ~= changed_page then
--             print('Page Changed [' .. current_page .. '] -> [' .. changed_page .. ']')
--             current_page = changed_page
--         end
--     end
-- end

-- timer_funcs = {}
-- timer_funcs['testTimer'] = page_monitor_func()

local win = disp:AddWindow({
    ID = "ExampleUI",
    WindowTitle = "More UI Features",
    -- Geometry = {640+150, 480-200, 850, 900 }, -- Removed to showcase Auto Centering Windows
    WindowFlags = {
        Window = true,
        WindowStaysOnTopHint = true,
    },

    Margin = 10,

    ui:VGroup{
        ID = "root",
        FixedSize = {600, 700}, -- Only Sets Size, Position Defaults to Center of Screen
        ui:TextEdit{ ID = "Logo", HTML = "<center><a href='https://fusionpixelstudio.com/'><img src='"..logoB64.."'>", ReadOnly = true, FrameStyle = 0, Events = { AnchorClicked = true }, Weight = 0 },
        ui:Label{ Text = "🤓 The Advanced Examples 🎉", Alignment = {AlignCenter = true}, Weight = 0, StyleSheet = TITLE_CSS },
        ui:Tree{ ID = "ExampleTree", AlternatingRowColors = true, RootIsDecorated = false, HeaderHidden = false, ReadOnly = false },
        ui:Button{ ID = "Go", Text = "👈 Go To Selected Clip 👉", Weight = 0, StyleSheet = BUTTON_CSS },
        ui:SpinBox{ ID = "TestNums", Prefix = "Item ", Suffix = " Of "..#video_clips-1, Value = #video_clips/2, Maximum = #video_clips-1, Minimum = 0, ReadOnly = false, Wrapping = true, Weight = 0 },
        ui:HGroup{
            Weight = 0,
            ui:Label{ Text = "Color Influence", Weight = 0 },
            ui:Slider{ ID = "TreeColors", Value = 100, Minimum = 0, Weight = 1, Events = { SliderMoved = true } },
        },
        ui:ColorPicker { ID = "Colors", Text = "Tree Row Color", DoAlpha = false, Tracking = true, Weight = 0 }
    }
})

local itms = win:GetItems()

itms.ExampleTree:SetHeaderLabels({"Video", "Audio?", "Start Time"})
itms.ExampleTree.ColumnWidth[0] = 475
itms.ExampleTree.ColumnWidth[1] = 50
itms.ExampleTree.ColumnWidth[2] = 20

for i = 1, #video_clips do
    local it = itms.ExampleTree:NewItem()
    if video_clips[i] then
        it.Text[0] = video_clips[i]:GetName()
    end
    for n = 1, #audio_clips do
        if audio_clips[n] and video_clips[i]:GetStart() == audio_clips[n]:GetStart() then
            -- it.Text[1] = audio_clips[n]:GetName()
            it.Text[1] = "Yes"
            break
        end
    end
    if it.Text[1] ~= "Yes" then
        it.Text[1] = "No"
    end
    it.TextAlignment[1] = 'AlignVCenter'
    if video_clips[i] then
        local startFrame = video_clips[i]:GetStart()
        local timeline_clip = GetTimelineClipFromMediaPool(timeline:GetName())
        local fps = timeline_clip:GetClipProperty("FPS")
        it.Text[2] = tostring(ConvertFrameToTimecode(startFrame, fps))
        -- it.Text[2] = tostring(video_clips[i]:GetStart())
    end
    itms.ExampleTree:AddTopLevelItem(it)
end

win.On.Logo.AnchorClicked = LinkClick

local currentItem
local lastItem

local currentValue = itms.TreeColors.Value
lastItem = currentItem
currentItem = itms.ExampleTree:TopLevelItem(itms.TestNums.Value)
if lastItem and lastItem ~= currentItem then
    lastItem.BackgroundColor[0] = {R = 0, G = 0, B = 0, A = 0}
    lastItem.BackgroundColor[1] = {R = 0, G = 0, B = 0, A = 0}
    lastItem.BackgroundColor[2] = {R = 0, G = 0, B = 0, A = 0}
end
currentItem.BackgroundColor[0] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
currentItem.BackgroundColor[1] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
currentItem.BackgroundColor[2] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
currentValue = nil

function win.On.TreeColors.SliderMoved(ev)
    local currentValue = ev.Value
    lastItem = currentItem
    currentItem = itms.ExampleTree:TopLevelItem(itms.TestNums.Value)
    if lastItem and lastItem ~= currentItem then
        lastItem.BackgroundColor[0] = {R = 0, G = 0, B = 0, A = 0}
        lastItem.BackgroundColor[1] = {R = 0, G = 0, B = 0, A = 0}
        lastItem.BackgroundColor[2] = {R = 0, G = 0, B = 0, A = 0}
    end
    currentItem.BackgroundColor[0] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
    currentItem.BackgroundColor[1] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
    currentItem.BackgroundColor[2] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
end

function win.On.Colors.ColorChanged(ev)
    local currentValue = itms.TreeColors.Value
    lastItem = currentItem
    currentItem = itms.ExampleTree:TopLevelItem(itms.TestNums.Value)
    if lastItem and lastItem ~= currentItem then
        lastItem.BackgroundColor[0] = {R = 0, G = 0, B = 0, A = 0}
        lastItem.BackgroundColor[1] = {R = 0, G = 0, B = 0, A = 0}
        lastItem.BackgroundColor[2] = {R = 0, G = 0, B = 0, A = 0}
    end
    currentItem.BackgroundColor[0] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
    currentItem.BackgroundColor[1] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
    currentItem.BackgroundColor[2] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
end

function win.On.TestNums.ValueChanged(ev)
    local currentValue = itms.TreeColors.Value
    lastItem = currentItem
    currentItem = itms.ExampleTree:TopLevelItem(itms.TestNums.Value)
    if lastItem and lastItem ~= currentItem then
        lastItem.BackgroundColor[0] = {R = 0, G = 0, B = 0, A = 0}
        lastItem.BackgroundColor[1] = {R = 0, G = 0, B = 0, A = 0}
        lastItem.BackgroundColor[2] = {R = 0, G = 0, B = 0, A = 0}
    end
    currentItem.BackgroundColor[0] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
    currentItem.BackgroundColor[1] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
    currentItem.BackgroundColor[2] = {R = (itms.Colors.Color['R']), G = (itms.Colors.Color['G']), B = (itms.Colors.Color['B']), A = (currentValue/100)}
end

function win.On.Go.Clicked(ev)
    -- local currentItem 
    -- currentItem = itms.ExampleTree:CurrentItem()
    local timeCode = currentItem.Text[2]
    timeline:SetCurrentTimecode(timeCode)
end

function win.On.ExampleUI.Close(ev)
    disp:ExitLoop()
end

-- function disp.On.Timeout(ev)
--     timer_funcs[ev.who]()   -- ev.who is the ID of the timer that timed out.
-- end

-- monitorTimer:Start()
win:RecalcLayout()
win:Show()
disp:RunLoop() -- Run until "ExitLoop"
win:Hide()
-- monitorTimer:Stop()
