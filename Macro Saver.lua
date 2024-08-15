-- Define group operator and tool name
local operator = "GroupOperator" -- Or MacroOperator
local toolName = "MYTOOL"

local mainInput = "EffectMask"
local mainOutput = "MainOutput"
local sourceTool = "Text1"
local inputs = {"StyledText", "Font", "Style", "Size"}

-- Create Macro Table
local macro = {
  Tools = {}
}
macro.Tools = table.ordered()
macro.Tools[toolName] = { __ctor = operator }
local tools = macro.Tools

tools[toolName].ViewInfo = { __ctor = "GroupInfo" }
tools[toolName].Inputs = {}
tools[toolName].Inputs = table.ordered()
tools[toolName].Outputs = {}
tools[toolName].Outputs = table.ordered()

-- This function adds an input to the tool
local function addInputToTool(targetToolName, targetInputName, targetSource)
    tools[targetToolName].Inputs[targetInputName] = {
        __ctor = "InstanceInput", -- required
        SourceOp = sourceTool, -- required
        Source = targetSource, -- required
        ControlGroup = 1, -- required for all grouped controls
        Page = "Text" -- optional
    }
end

-- Adding inputs using the function we made above ^
addInputToTool(toolName, mainInput, "EffectMask")
for _, v in ipairs(inputs) do
    addInputToTool(toolName, v, v)
end

-- Add an external output, referencing Node's Output
tools[toolName].Outputs[mainOutput] = { __ctor = "InstanceOutput", SourceOp = sourceTool, Source = "Output" }

local selected = comp:GetToolList(true)
-- get a table of settings for the actual tools to go in our new group
t = comp:CopySettings(selected)
tools[toolName].Tools = t.Tools

-- paste it back into the comp
comp:Paste(macro)