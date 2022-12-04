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

local function containsPair(tbl)
  if tbl[1].lower >= tbl[2].lower and tbl[1].higher <= tbl[2].higher or
     tbl[2].lower >= tbl[1].lower and tbl[2].higher <= tbl[1].higher then
      return 1
  end

  return 0
end

local file = 'data.txt'
local lines = lines_from(file)
local sum = 0

for k, v in pairs(lines) do
  local _pairs = v:split(',')
  local obj = {}
  for i=1,2 do
    local tmp = _pairs[i]:split('-')
    obj[i] = {}
    obj[i].lower = tonumber(tmp[1])
    obj[i].higher = tonumber(tmp[2])
  end
  sum = sum + containsPair(obj)
end

print (sum)
