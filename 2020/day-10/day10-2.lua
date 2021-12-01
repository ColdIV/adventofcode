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


local c = {}
function paths(i)
    if i >= #adapters then return 1 end
    if c[i] then return c[i] end
    
	local sum = 0
    local m = #adapters
    if i + 4 < #adapters then m = i + 4 end
    
	for j = i + 1, m do
        if adapters[j] - adapters[i] <= 3 then
            sum = sum + paths(j)
        end
    end
    
	c[i] = sum
    
	return sum
end

print(paths(1))
