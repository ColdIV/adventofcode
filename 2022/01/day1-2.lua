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
local elves = {}
local tmp = 0

for k, v in pairs(lines) do
  if v == "" then
    table.insert(elves, tmp)
    tmp = 0
  else
    tmp = tmp + tonumber(v)
  end
end

local sum = 0
table.sort(elves) -- lazy solution
for i=0, 2 do
  sum = sum + elves[#elves - i]
end
print (sum)