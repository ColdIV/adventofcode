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
local marker = ""
local mMap = {}

for k, v in pairs(lines) do
    for i = 1, string.len(v) do
        local char = v:sub(i,i)
        if mMap[char] ~= nil then
            local tmpPos = mMap[char]
            for j = 1, math.min(tmpPos, marker:len()) do
                mMap[marker:sub(j,j)] = nil
            end
            marker = marker:sub(tmpPos + 1) .. char
        else
            marker = marker .. char
        end

        mMap[char] = marker:len()

        if string.len(marker) == 14 then
            sum = i
            break
        end
    end
end

print (sum)
