local resolve = Resolve()
local projectManager = resolve:GetProjectManager()
local project = projectManager:GetCurrentProject()
local mp = project:GetMediaPool()
local all_of_that = Resolve():GetProjectManager():GetCurrentProject():GetMediaPool()

local timeline = mp:CreateEmptyTimeline("The Future")

-- local tmlfusionComp = timeline:InsertFusionCompositionIntoTimeline()

local tmlitm = mp:ImportMedia('C:\\Users\\Asher Roland\\Downloads\\newicon-possible.jpeg')

local clip = mp:AppendToTimeline(tmlitm)

local tmlfusionComp = timeline:CreateFusionClip(clip)

local Comps = tmlfusionComp:GetFusionCompNameList()

tmlfusionComp:LoadFusionCompByName(Comps[0])

resolve:OpenPage("fusion")

local fusion = Fusion()
local fu = fusion
local composition = fu.CurrentComp
local comp = composition
SetActiveComp(comp)

-- bmd.wait(2)
-- dump(bmd)

comp:Lock()
local bg = comp:AddTool('Background', 1, 3)
local mrg = comp:AddTool('Merge', 1, 1)
local bg2 = comp:AddTool('Background', -3, 1)
local txt = comp:AddTool('TextPlus', -1, -2)
local mrg2 = comp:AddTool('Merge', -1, 1)

-- comp:ChooseTool()
-- local bg = Background()

MediaOut1:ConnectInput("Input", Merge1)
Merge1:ConnectInput("Background", Background1)
Merge1:ConnectInput("Foreground", Merge2)
Merge2:ConnectInput("Background", Background2)
Merge2:ConnectInput("Foreground", Text1)

Text1.StyledText[0] = "My Text Baby!"
Background1.TopLeftAlpha[0] = 0
Merge1:SetInput('Size', 1.25, 10)

flow = composition.CurrentFrame.FlowView

flow:SetPos(MediaIn1, 5, 4)

comp:SetActiveTool(comp.GetToolList(False, “Merge”)[0])
comp:Unlock()