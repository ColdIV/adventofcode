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

local function getPrio(line)
  for i=1, (#line / 2) do
    for j=((#line / 2) + 1), #line do
      if line:sub(i,i) == line:sub(j,j) then
        local tmp = line:sub(i,i)
        if string.byte(tmp) > 96 then -- 97 is a in ascii
          return string.byte(tmp) - 96
        else -- 65 is A in ascii
          return string.byte(tmp) - 64 + 26 -- + 26 for some reason
        end
      end
    end
  end
end

for _, line in pairs(lines) do
  sum = sum + getPrio(line)
end

print (sum)
