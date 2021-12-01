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
local sum = {}

for k, v in pairs(lines) do
	for i = 1, #lines - 2, 1 do
		sum[i] = sum[i] or {c = 0, sum = 0}
		if sum[i].c < 3 then
			sum[i].c = sum[i].c + 1
			sum[i].sum = sum[i].sum + v
		end
		if sum[i].c == 1 then break end
	end
end

for i = 1, #sum, 1 do
	print (sum[i].sum)
end


local res = 0
for i = 2, #sum, 1 do
	if sum[i].sum > sum[i - 1].sum then
		res = res + 1
	end
end

print (res)