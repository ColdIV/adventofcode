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
local lineCount = 0
local m = {}

for _, v in pairs(lines) do
	-- print ("Line: " .. v)
	lineCount = lineCount + 1
	if (v == "") then
		lineCount = lineCount - 1
		for _, value in pairs(m) do
			-- print (value, lineCount)
			if (value == lineCount) then
				sum = sum + 1
			end
		end
		m = {}
		lineCount = 0
	else	
		for c in string.gmatch(v, ".") do
			if m[c] == nil then m[c] = 1
			else m[c] = m[c] + 1 end
			-- print ("Char: " .. c)
		end
	end
	
end

-- ugly fix
for _, value in pairs(m) do
	-- print (value, lineCount)
	if (value == lineCount) then
		sum = sum + 1
	end
end

print (sum)
