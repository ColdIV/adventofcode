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

---@diagnostic disable-next-line: duplicate-set-field
function string:split(sep)
  sep = sep or ":"
  local fields = {}
  local pattern = string.format("([^%s]+)", sep)
  local _ = self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

local file = 'data.txt'
local lines = lines_from(file)
local sum = 0

local dirs = {}
local path = {}
local pathIndex = 0
for k, v in pairs(lines) do
  local data = v:split(' ')
  if data[1] == '$' then
    -- handle command
    if data[2] == 'cd' then
      if data[3] == '..' then
        path[pathIndex] = nil
        pathIndex = pathIndex - 1
      else
        pathIndex = pathIndex + 1
        path[pathIndex] = data[3]
      end
    else if data[2] == 'ls' then
      -- i don't really care about ls, I just handle input
    end
  elseif data[1] == 'dir' then
    -- add dir

  else
    -- add file
    
  end
end

print (sum)
