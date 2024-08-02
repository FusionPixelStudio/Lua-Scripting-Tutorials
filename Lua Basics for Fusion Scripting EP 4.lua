local resolve = app:GetResolve()
local projectManager = resolve:GetProjectManager()
local mediaStorage = resolve:GetMediaStorage()
local project = projectManager:GetCurrentProject()
local mediaPool = project:GetMediaPool()
local rootBin = mediaPool:GetRootFolder()
local bins = rootBin:GetSubFolderList()

--[[
    Helper Functions
]]

function find_bin(bins, userbin)
    for _, bin in ipairs(bins) do
        name = bin:GetName()
        sub_bins = bin:GetSubFolderList()
        if name == userbin then
            return bin
        end
        if #sub_bins > 0 then
            result = find_bin(sub_bins, userbin)
            if result then
                return result
            end
        end
    end
    return nil
end

function get_final_folder(path)
    -- Normalize path separators for cross-platform compatibility
    path = path:gsub("\\", "/")
    -- Remove any trailing slash
    if path:sub(-1) == "/" then
        path = path:sub(1, -2)
    end
    -- Find the last occurrence of '/'
    local last_slash = path:match(".*/")
    -- Extract the final folder name
    local final_folder = path:sub(last_slash:len() + 1)
    return final_folder
end

--[[
    GUI Creation
]]

local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)

MainWindow = disp:AddWindow(
    {
        ID = "MainWind",
        WindowTitle = "Import and Append",
        Geometry = { 950, 400, 300, 150 }, -- {PosX, PosY, SizeW, SizeH}
        ui:VGroup{
            ID = "root",
            ui:HGroup{
                ui:LineEdit{ ID = "FilePath", PlaceholderText = "Folder Path", ReadOnly = true, Weight = 0.75 },
                ui:Button{ ID = "Browse", Text = "Browse", Weight = 0.25 }
            },
            ui:HGroup{
                ui:Label{ ID = "Bin", Text = "Bin for Folder", Weight = 0.25 },
                ui:ComboBox{ ID = "Bins", Weight = 0.75 },
            },
            ui:Label{ Weight = 0, FrameStyle = 4 },
            ui:HGroup{
                ui:Label{ ID = "TimelineName", Text = "Timeline Name", Weight = 0.25 },
                ui:LineEdit{ ID = "TMLName", PlaceholderText = "My Cool Timeline", Weight = 0.75},
            },
            ui:Button{ ID = "Run", Text = "Start Import"}
        }
    }
)

itm = MainWindow:GetItems()

--[[
    GUI ComboBox Filling
]]

itm.Bins:AddItem(rootBin:GetName())
function fillCombo(bins)
    for _, bin in ipairs(bins) do
        local test = bin:GetSubFolderList()
        if #test < 1 then
            itm.Bins:AddItem(bin:GetName())
        else
            itm.Bins:AddItem(bin:GetName())
            fillCombo(test)
        end
    end
end
fillCombo(bins)

--[[
    GUI User Interactions
]]

function MainWindow.On.Browse.Clicked(ev)
    local folderPath = app:MapPath(fu:RequestDir(
        "",
        {
            FReqS_Title = 'Choose Containing Folder...',
        }
    )
)

    itm.FilePath.Text = folderPath
end

function MainWindow.On.Run.Clicked(ev)
    local files = mediaStorage:GetFileList(itm.FilePath.Text)
    print(bmd.writestring(files))

    local userBin = itm.Bins.CurrentText

    if userBin == "Master" then
        ImportBin = rootBin
    else
        ImportBin = find_bin(bins, userBin)
    end

    if not ImportBin then
        print("ERROR BIN CANNOT BE FOUND")
        return nil
    end

    mediaPool:SetCurrentFolder(ImportBin) -- Makes the Current Bin the User's Chosen Bin
    local filesFolder = get_final_folder(itm.FilePath.Text) -- Reduces a FilePath down to it's last folder using string operations
    mediaPool:AddSubFolder(mediaPool:GetCurrentFolder(), filesFolder) -- Create a new Bin with the same name as the folder that the images/videos are in. This sets the bin as the current bin
    local mpItems = mediaStorage:AddItemsToMediaPool(files) -- Imports Clips into Current Bin
    mediaPool:SetCurrentFolder(rootBin) -- Changes Bin back to Master
    mediaPool:CreateTimelineFromClips(itm.TMLName.Text, mpItems) -- Creates new Timeline in the Master Bin(because it is current) using the media pool clips that were just imported
    disp:ExitLoop()
end

function MainWindow.On.MainWind.Close(ev)
    disp:ExitLoop()
end

--[[
    GUI Run
]]

MainWindow:Show()
disp:RunLoop() -- Run until "ExitLoop"
MainWindow:Hide()
