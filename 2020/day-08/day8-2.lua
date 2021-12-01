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
local commands = {}
local acc = 0

for k, v in pairs(lines) do
	local command = string.sub(v, 1, 3)
	local value = tonumber(string.sub(v, 5))
	commands[k] = {command, value}
	commands[k].command = command
	commands[k].value = value
	-- print (commands[k].command, commands[k].value)
end

local position = 1
local commandsUsed = {}

function run ()
	if position == #commands then return true end
	if commandsUsed[position] == true then return false end
	commandsUsed[position] = true
	
	if commands[position].command == "acc" then
		acc = acc + commands[position].value
		position = position + 1
	elseif commands[position].command == "nop"  then
		position = position + 1
	elseif commands[position].command == "jmp" then
		position = position + commands[position].value
	end
	
	return run()
end

function findError ()
	position = 1
	commandsUsed = {}
	
	-- jmp to nop
	for i = 1, #commands, 1 do
		if commands[i].command == "jmp" then 
			commands[i].command = "nop"
			if run() then 
				-- print ("jmp", i, acc)
				return acc
			else 
				position = 1
				commandsUsed = {}
				commands[i].command = "jmp" 
				acc = 0
			end
		end
	end
	
	-- nop to jmp
	for i = 1, #commands, 1 do
		if commands[i].command == "nop" then 
			commands[i].command = "jmp"
			if run() then 
				-- print ("nop", i, acc)
				return acc
			else
				position = 1
				commandsUsed = {}			
				commands[i].command = "nop" 
				acc = 0
			end
		end
	end
	
	return 0
end

print (findError())
