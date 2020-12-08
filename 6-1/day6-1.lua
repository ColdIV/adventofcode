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
local m = {}

for _, v in pairs(lines) do
	-- print ("Line: " .. v)
	if (v == "") then
		for key, _ in pairs(m) do
			-- print ("+")
			sum = sum + 1
		end
		m = {}
	else	
		for c in string.gmatch(v, ".") do
			m[c] = true
			-- print ("Char: " .. c)
		end
	end
	
end

-- ugly fix
for key, _ in pairs(m) do
	-- print ("+")
	sum = sum + 1
end

print (sum)
