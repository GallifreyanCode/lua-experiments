local Gamestate = require 'libs/gamestate'
local window = require 'gui/window'
local camera = require 'util/camera'
local menu = Gamestate.new()
local initTime
local currentRadius = 10
local timeDelta = 0
local angle = 0
local scaleX = 10
local scaleY = 10
local tardisX = 200
local tardisY = 100
local tardisRotation = 0
local lightning = 0

function menu:init()
    initTime = love.timer.getTime()
	displayString = true
	image = love.graphics.newImage("images/tardis.png")
	lightningImage = love.graphics.newImage("images/lightning.png")
end

function menu:update(dt)
    --[[local currentTime = love.timer.getTime()
   	local timeDelta = math.floor(currentTime - initTime)
    currentRadius = 10 * timeDelta
    currentX = 200 + (timeDelta*2)
    currentY = 200 + (timeDelta*2)
    --]]
    angle = 10
    --first movement from right to left
    if scaleX > 3 then
    	tardisX, tardisY = tardisX-0.02, tardisY-0.02
    	scaleX, scaleY = scaleX-0.01, scaleY-0.01
    	elseif scaleX > 1 then
    	 --second movement
    	tardisX, tardisY = tardisX+0.05, tardisY+0.05
   		tardisRotation = tardisRotation+0.01
   		scaleX, scaleY = scaleX-0.001, scaleY-0.001
   		print(tardisRotation)
   		elseif tardisRotation > 19.2 then
   			lightning = 1
   			tardisRotation = tardisRotation-0.01
   			else
   			lightning = 0
   			tardisRotation = tardisRotation-0.01
   			--draw character
   			
    end
end

function menu:draw()
 	local oriantation
 	local shearingX = 0
 	local shearingY = shearingX
   
    
	timeDelta = timeDelta + 1
	currentRadius = 10 * timeDelta
	local counter = currentRadius

	if counter>10 then
		counter = 10
	end
	for var=0, counter do
		if var>5 then
			love.graphics.circle("line", 200 + (var*2), 200 + (var*2), (4*var+(var*var)))
		else
			love.graphics.circle("line", 200 + (var*2), 200 + (var*2), (4*var+(var*var)))
		end
	end
	 --[[
	love.graphics.circle("line", currentX, currentY, currentRadius)
	--]]
	 love.graphics.draw(image, tardisX, tardisY, tardisRotation, scaleX, scaleY, shearingX, shearingY)

	 if lightning == 1 then
	 	love.graphics.draw(lightningImage, 100, -100, 20, 1, 1, shearingX, shearingY)
	 end
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
