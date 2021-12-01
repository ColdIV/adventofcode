function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

---

local file = 'data.txt'
local lines = lines_from(file)
local sum = 0
local adapters = {}

for k, v in pairs(lines) do
	-- * 1 to convert to int
	adapters[k] = v * 1
end

-- add outlet
table.insert(adapters, 0)

-- either i'm stupid or it's that simple
table.sort(adapters)

-- add device
table.insert(adapters, adapters[#adapters] + 3)

local diffs = {}
diffs[1] = 0
diffs[2] = 0
diffs[3] = 0
for i = 2, #adapters, 1 do
	local t = adapters[i] - adapters[i - 1]
	diffs[t] = diffs[t] + 1
end

print (diffs[1] * diffs[3])
