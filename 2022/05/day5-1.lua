local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

---

local file = 'data.txt'
local lines = lines_from(file)
local sum = 0
-- this name was a bad choice, but I refuse to change it now!
local raw_stacks_horizontal = {}
local stacks = {}

---@diagnostic disable-next-line: duplicate-set-field
function string:split(sep)
  sep = sep or ":"
  local fields = {}
  local pattern = string.format("([^%s]+)", sep)
  local _ = self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

local function getCrates(str, stackl)
    local strl = string.len(str)
    -- space between crates in str is 4
    -- first crate is at position 2
    -- e.g. [b] [w] ...
    --       ^   ^
    -- pos   2   6  ...
    local stackPos = 1
    for cratePos = 2, strl, 4 do
        local crate = string.sub(str, cratePos, cratePos)
        stacks[stackPos] = stacks[stackPos] or {}
        stacks[stackPos][stackl] = stacks[stackPos][stackl] or {}
        if crate ~= " " then
            stacks[stackPos][stackl] = crate
        else
            stacks[stackPos][stackl] = nil
        end
        stackPos = stackPos + 1
    end
end

local function buildStacks(num)
    local stack_count = string.sub(raw_stacks_horizontal[#raw_stacks_horizontal], string.len(raw_stacks_horizontal[#raw_stacks_horizontal]))

    for i=#raw_stacks_horizontal-1, 1, -1 do
        getCrates(raw_stacks_horizontal[i], #raw_stacks_horizontal-i)
        --print(i, raw_stacks_horizontal[i])
    end
end

local raw_stack_complete = false
local cmds = {}
local cmds_offset

for k, v in pairs(lines) do
    if not raw_stack_complete then
        if v == "" then
            raw_stack_complete = true
            buildStacks(k)
            cmds_offset = k
        else
            raw_stacks_horizontal[k] = v
        end
    else
        cmds[k - cmds_offset] = v:split(' ')
    end
end

local function doCmd(cmd)
    -- yeah, I am lazy.
    -- also trying to learn vim right now...
    -- :q!  I'm fine ;)
    local amount = tonumber(cmd[2])
    local from = tonumber(cmd[4])
    local to = tonumber(cmd[6])
    --print('move ' .. amount .. ' from ' .. from .. ' to '.. to)
    for i=1, amount do
        local item = table.remove(stacks[from],#stacks[from])
        stacks[to][#stacks[to]+1] = item
    end
end

--[[
for i=1, #stacks do
    print('#' .. i)
    for j=1, #stacks[i] do
        print(stacks[i][j])
    end
end
--]]

print('before')
do
    local lastCrate
    for i=1, #stacks do
        if stacks[i][#stacks[i]] then
            print(stacks[i][#stacks[i]])
        end
    end
end

for i=1, #cmds do
    doCmd(cmds[i])
end

print('after')
do
    local lastCrate
    for i=1, #stacks do
        if stacks[i][#stacks[i]] then
            print(stacks[i][#stacks[i]])
        end
    end
end

--[[
for i=1, #stacks do
    print('#' .. i)
    for j=1, #stacks[i] do
        print(stacks[i][j])
    end
end
--]]

--print (sum)
