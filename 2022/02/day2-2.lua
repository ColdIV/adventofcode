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
  ['A'] = 1,
  ['B'] = 2,
  ['C'] = 3,
  [1] = 'A',
  [2] = 'B',
  [3] = 'C'
}

-- if difference between values is 1, higher value wins
-- if difference between values is 0, it's a tie
-- if difference between values is 2, lower value wins

for k, v in pairs(lines) do
  local tmp = v:split(' ')
  local foe, outcome = shapes[tmp[1]], tmp[2]
  if outcome == 'X' then -- lose
    if foe - 1 > 0 then
      sum = sum + foe - 1 + 0 -- no bonus for losers
    else
      sum = sum + shapes['C'] + 0
    end
  elseif outcome == 'Y' then --draw
    sum = sum + foe + 3 -- 3 for draw
  else -- win
    if foe + 1 < 4 then
      sum = sum + foe + 1 + 6 -- 6 for winning
    else
      sum = sum + shapes['A'] + 6
    end
  end
end

print (sum)
