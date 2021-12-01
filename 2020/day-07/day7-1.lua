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
local targets = {"shinygold"}
local bagsContainTarget = {}
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
			contains[line[j+1] .. line[j+2]] = line[j]
		end
		bags[bag] = contains
		break
	end
end

local unique = {}

function increment()
	for bag, contains in pairs(bags) do
		for k, _ in pairs(contains) do
			for i = 1, #targets, 1 do
				if k == targets[i] then
					if not unique[bag] == true then
						table.insert(targets, bag)
						unique[bag] = true
						-- print (bag)
						sum = sum + 1
						return false
					end
				end
			end
		end
	end
	
	return true
end

while not increment() do end

print (sum)
