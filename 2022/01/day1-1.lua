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
local max = 0
local tmp = 0

for k, v in pairs(lines) do
  if v == "" then
    if tmp > max then
      max = tmp
    end
    tmp = 0
  else
    tmp = tmp + tonumber(v)
  end
end

print (max)
