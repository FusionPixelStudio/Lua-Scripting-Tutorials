
-- [[ Variables ]] --
_G.Variable = "All"
local also_A_variable = 10
local stillaVariable = true

local reverenceVariable = Variable or "None"

local table = {1, "String", false, {"also", "table", {"Still", "Table", true}}}

local myString = table[2]

print(myString)

local complexTable = {
    Item1 = 10,
    Item2 = "False",
    Item3 = true
}

print(bmd.writestring(complexTable))

-- [[ if statements ]] --
if reverenceVariable == "All" then 
    print("ALL")
elseif reverenceVariable == "None" then
    print("NONE")
else
    print("ERROR!")
end

if also_A_variable > 20 then
    print("BIG")
elseif also_A_variable <= 5 then
    print("SMOL")
end

if not stillaVariable then
    print("Sorry, But there is nothing here")
elseif stillaVariable ~= false then
    print("Congrats! You Win!")
end

--[[ LOOPS ]]--

-- for loops
for i = 0, 10, 1 do
    print(i)
end

for i = 0, -10, -1 do
    print(i)
end

for _, i in ipairs(table) do
    if type(i) ~= "table" then
        print(i)
    else
        for _, v in ipairs(i) do
            print(v)
        end
    end
end

-- while loops
local v = 0
while true do
    print(v)
    v = v + 1
    if v == 10 then
        break
    end
end

local t = 0
while t <= 10 do
    print(t)
    t = t + 1
end

-- repeat until loops
local a = 0
repeat
    print(a, "*")
    a = a + 2
until a >=10

-- [[ FUNCTIONS ]] --

-- Create Function
local function FunctionName(condition1, condition2)
    String = condition1
    Bool = condition2
    for _ = 0, 10, 1 do
        print("String: "..String.."\nBoolean: "..tostring(Bool))
    end
end

-- Call Function
FunctionName("This is my String", false)

-- Recusive Looping
local function MyFunc(table)
    for _, i in ipairs(table) do
        if type(i) ~= "table" then
            print(i)
        else
            MyFunc(i)
        end
    end
    return table
end

-- Passing Through Variable
local newTable = MyFunc(table)


-- [[ HOMEWORK ]] --

--[[ 
    Create a script that tells a story in the console. Have the names be variables, and run it in a Function. Once you have finished, post it in the discord! https://discord.gg/JyWcmYN3jS 
--]]
