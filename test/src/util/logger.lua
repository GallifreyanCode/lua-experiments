require 'socket'
local logger = {}
local level = "info"

function logger:setLevel(newlevel)
	level = newlevel
end

function logger:debug(message)
	if level == "debug" then
		print("Logger - " .. socket.gettime() .. " - [DEBUG] " .. message)
	end
end

function logger:info(message)
	if level == "info" then
		print("Logger - " .. socket.gettime() .. " - [INFO] " .. message)
	elseif level == "debug" then
		print("Logger - [INFO] " .. message)
	end
end

function logger:error(message)
	if level == "error" then
		print("Logger - " .. socket.gettime() .. " - [ERROR] " .. message)
	elseif level == "debug" then
		print("Logger - [ERROR] " .. message)
	end
end

return logger