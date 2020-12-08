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
local bags = {}
local sum = 0

for _, v in pairs(lines) do
	local line = {}
	for i in string.gmatch(v, "%S+") do
		table.insert(line, i)
	end
	
	for i = 1, #line, 1 do
		-- print ("main bag: ", line[1], line[2])
		local bag = line[1] .. line[2]
		local contains = {}
		-- print ("sub bags: ")
		for j = 5, #line, 4 do
			-- print ("", line[j+1], line[j+2], line[j])
			if not (line[j] == "no" or line[j] == "0") then
				contains[line[j+1] .. line[j+2]] = line[j]
			end
		end
		bags[bag] = contains
		break
	end
end

function recur (bag)
	local res = 0
	for k, v in pairs(bags[bag]) do
		local t = recur(k)
		-- if t > 0 then
			-- print (recur(k), k, v)
		-- end
		res = res + tonumber(v) + tonumber(v) * recur(k)
	end
	
	return res
end

sum = recur("shinygold")

print (sum)
