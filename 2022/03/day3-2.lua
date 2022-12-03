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

local function getPrio(group)
  -- print ('--- group ---')
  -- print(group[1])
  -- print(group[2])
  -- print(group[3])
  -- print ('--- xxxxx ---')

  -- i'm sure there is a better way... ¯\_(ツ)_/¯
  for i=1, #group[1] do
    for j=1, #group[2] do
      for k=1, #group[3] do
        if group[1]:sub(i,i) == group[2]:sub(j,j) and group[1]:sub(i,i) == group[3]:sub(k,k) then
          local tmp = group[1]:sub(i,i)
          if string.byte(tmp) > 96 then -- 97 is a in ascii
            return string.byte(tmp) - 96
          else -- 65 is A in ascii
            return string.byte(tmp) - 64 + 26 -- + 26 for some reason
          end
        end
      end
    end
  end
end

local group = {
  [1] = '',
  [2] = '',
  [3] = ''
}

for _, line in pairs(lines) do
  local count = 1
  for i=1, #group do
    if group[i] == '' then
      group[i] = line
      break
    end
    count = count + 1
  end
  if count == 3 then
    sum = sum + getPrio(group)
    -- reset group
    group = {
      [1] = '',
      [2] = '',
      [3] = ''
    }
  end
end

print (sum)
