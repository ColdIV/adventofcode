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

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

local file = 'data.txt'
local lines = lines_from(file)
local sum = 0

local shapes = {
  ['X'] = 1,
  ['Y'] = 2,
  ['Z'] = 3,
  ['A'] = 1,
  ['B'] = 2,
  ['C'] = 3
}

-- if difference between values is 1, higher value wins
-- if difference between values is 0, it's a tie
-- if difference between values is 2, lower value wins

for k, v in pairs(lines) do
  local tmp = v:split(' ')
  local foe, me = shapes[tmp[1]], shapes[tmp[2]]
  if me == foe + 1 or me + 2 == foe then
    sum = sum + 6 + me -- 6 for winning
  elseif me == foe then
    sum = sum + 3 + me -- 3 for draw
  else
    sum = sum + 0 + me -- no bonus for losers
  end
end

print (sum)
