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
local nums = {}
local preamble = 25

for k, v in pairs(lines) do
	nums[k] = v
end

function check()
	for i = preamble + 1, #nums, 1 do
		local found = false
		
		for j = i - preamble, i - 1, 1 do
			for k = i - preamble, i - 1, 1 do
				if j ~= k then
					-- * 1.0 to convert to float
					if nums[i] * 1.0 == nums[k] + nums[j] then
						found = true
					end
				end
			end
		end
		
		if not found then return nums[i] end
	end
	
	-- not found
	return -1
end

print (check())
