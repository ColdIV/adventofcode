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

for k, v in pairs(lines) do
	if k > 1 then
		if lines[k] > lines[k-1] then
			sum = sum + 1
		end
	end
end

print (sum)