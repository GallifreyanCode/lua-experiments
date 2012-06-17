local Gamestate = require 'libs/gamestate'
local window = require 'gui/window'
local camera = require 'util/camera'
local menu = Gamestate.new()
local initTime
local currentRadius = 10
local timeDelta = 0

function menu:init()
    initTime = love.timer.getTime()
	displayString = true
end

function menu:update(dt)
    --[[local currentTime = love.timer.getTime()
   	local timeDelta = math.floor(currentTime - initTime)
    currentRadius = 10 * timeDelta
    currentX = 200 + (timeDelta*2)
    currentY = 200 + (timeDelta*2)
    --]]
end

function menu:draw()
	timeDelta = timeDelta + 1
	currentRadius = 10 * timeDelta
	for var=0, currentRadius/10 do
		if var>5 then
			love.graphics.circle("line", 200 + (var*2), 200 + (var*2), (4*var+(var*var)))
		else
			love.graphics.circle("line", 200 + (var*2), 200 + (var*2), (4*var+(var*var)))
		end
	end
	 --[[
	love.graphics.circle("line", currentX, currentY, currentRadius)
	--]]
end

-- music
function menu:enter()
    camera:setPosition(0, 0)
    self.bg = love.audio.play("audio/theme.mp3", "stream", true)
end

function menu:leave()
    love.audio.stop(self.bg)
end

return menu
