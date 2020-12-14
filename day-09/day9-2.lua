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
local nums = {}
local preamble = 25

for k, v in pairs(lines) do
	nums[k] = v
end

function findInvalid()
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
		
		if not found then return nums[i], i end
	end
	
	-- not found
	return -1, -1
end

local inv, index = findInvalid()

function findRange(inv, idx)
	inv = tonumber(inv)
	print (inv, idx)
	if idx == -1 then return end
	local s, e = 1, 2
	
	while e < idx and s < idx and s ~= e do
		local sum = 0.0
		for i = s, e, 1 do
			sum = sum + nums[i]
		end
		if sum > inv then s = s + 1
		elseif sum < inv then e = e + 1
		else return s, e end
	end
	
	return s, e
end

function solve(s, e)
	local mi, ma = nums[s], nums[s]
	for i = s, e, 1 do
		if nums[i] > ma then ma = nums[i] end
		if nums[i] < mi then mi = nums[i] end
	end
	
	return mi + ma
end

print (math.floor(solve(findRange(inv, index))))
