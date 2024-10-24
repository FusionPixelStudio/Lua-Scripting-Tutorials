local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)

local projectManager = resolve:GetProjectManager()
local project = projectManager:GetCurrentProject()
local mediaPool = project:GetMediaPool()
local timeline = project:GetCurrentTimeline()
local video_clips = timeline:GetItemListInTrack("video", 1)
local audio_clips = timeline:GetItemListInTrack("audio", 1)

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

local win = disp:AddWindow({
    ID = "ExampleUI",
    WindowTitle = "More UI Features",
    WindowFlags = {
        Window = true,
        WindowStaysOnTopHint = true,
    },

    Margin = 10,

    ui:VGroup{
        ID = "root",
        FixedSize = { 600, 700 },
        ui:Tree{ ID = "ExampleTree", AlternatingRowColors = true, RootIsDecorated = false, HeaderHidden = false },
        ui:Button{ ID = "Go", Text = "Go To Selected Clip", Weight = 0 }
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
        _G.name = video_clips[i]:GetName()
        _G.startFrame = video_clips[i]:GetStart()
        local timeline_clip = GetTimelineClipFromMediaPool(timeline:GetName())
        _G.fps = timeline_clip:GetClipProperty("FPS")
    end
    it.Text[0] = name or "No Clip"
    it.Text[2] = tostring(ConvertFrameToTimecode(startFrame, fps)) or "Unknown"
    for n = 1, #audio_clips do
        if audio_clips[n] and startFrame == audio_clips[n]:GetStart() then
            it.Text[1] = "Yes"
            break
        end
    end
    if it.Text[1] ~= "Yes" then
        it.Text[1] = "No"
    end
    itms.ExampleTree:AddTopLevelItem(it)
end

function win.On.Go.Clicked(ev)
    local currentItem
    currentItem = itms.ExampleTree:CurrentItem()
    local timecode = currentItem.Text[2]
    timeline:SetCurrentTimecode(timecode)
end

function win.On.ExampleUI.Close(ev)
    disp:ExitLoop()
end

win:RecalcLayout()
win:Show()
disp:RunLoop() -- Run until "ExitLoop"
win:Hide()

print("Script Finished!")