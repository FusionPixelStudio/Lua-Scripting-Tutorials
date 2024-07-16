local resolve = app:GetResolve()
local projectManager = resolve:GetProjectManager()
local mediaStorage = resolve:GetMediaStorage()
local project = projectManager:GetCurrentProject()
local mediaPool = project:GetMediaPool()
local rootBin = mediaPool:GetRootFolder()
local bins = rootBin:GetSubFolderList()

local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)

MainWindow = disp:AddWindow(
    {
        ID = "MainWind",
        WindowTitle = "Import And Append",
        Geometry = { 950, 400, 300, 150},
        ui:VGroup{
            ID = "root",
            ui:HGroup{
                ui:LineEdit{
                    ID = "FilePath",
                    PlaceholderText = "Folder Path",
                    ReadOnly = true,
                    Weight = 0.75
                },
                ui:Button{
                    ID = "Browse",
                    Text = "Browse",
                    Weight = 0.25
                },
            },
            ui:HGroup{
                ui:Label{ ID = "Bin", Text = "Bin for Folder", Weight = 0.25 },
                ui:ComboBox{ ID = "Bins", Weight = 0.75 },
            },
            ui:Label{ Weight = 0, FrameStyle = 4 },
            ui:HGroup{
                ui:Label{ ID = "TimelineName", Text = "Timeline Name", Weight = 0.25 },
                ui:LineEdit{ ID = "TMLName", PlaceholderText = "My Cool Timeline", Weight = 0.75 }
            },
            ui:Button{ ID = "Run", Text = "Start Import" }
        },
    }
)

local itm = MainWindow:GetItems()

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

function MainWindow.On.MainWind.Close(ev)
    disp:ExitLoop()
end

MainWindow:Show()
disp:RunLoop()
MainWindow:Hide()
print("FINSIHED")