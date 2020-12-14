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
local maxSeatId = 0

for k,v in pairs(lines) do
	-- v is the line
	local rowMin, rowMax = 0, 127
	local colMin, colMax = 0, 7
	for c in string.gmatch(v, ".") do 
		-- debug
		if false then print (v) end
		
		if c == "F" then
			rowMax = math.floor(rowMax - ((rowMax - rowMin) / 2))
		elseif c == "B" then
			rowMin = math.ceil(rowMax - ((rowMax - rowMin) / 2))
		elseif c == "R" then
			colMin = math.ceil(colMax - ((colMax - colMin) / 2))
		elseif c == "L" then
			colMax = math.floor(colMax - ((colMax - colMin) / 2))
		end
	end
	
	-- debug
	if (rowMax ~= rowMin or colMax ~= colMin) then
		print (rowMin .. " " .. rowMax .. " " .. colMin .. " " .. colMax)
		break
	end
	
	if maxSeatId < rowMax * 8 + colMax then
		maxSeatId = rowMax * 8 + colMax
	end
end

print (maxSeatId)

