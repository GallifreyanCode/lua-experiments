--[[
Global
--]]
local Gamestate = require 'libs/gamestate'
local window = require 'gui/window'
local camera = require 'util/camera'
local intro = Gamestate.new()
local introAnimationLength = 450
local currentAnimationTime = 0
local vortexLength = 30
local circleDY = 2
local circleStartingPoint = 0.3
local circleRadius = 0
local circleLineWidth = 2
local circleDeltaLineWidth = 0.05
local tardisImage
local tardisImageHalfW
local tardisImageHalfH
local tardisImageQuarterH

--[[
Init/Update/Draw
--]]
function intro:init()
	tardisImage = love.graphics.newImage("images/tardis.png")
    tardisImageHalfW = tardisImage:getWidth() / 2
    tardisImageHalfH = tardisImage:getHeight() / 2
    tardisImageQuarterH = tardisImage:getHeight() / 4
end

function intro:update(dt)
	currentAnimationTime = currentAnimationTime + 0.1
end

function intro:draw()
    local startX
    local startY
    startX, startY = intro:drawVortex(window.width, window.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle('fill', startX, startY+8, 15, 60)
   	love.graphics.setColor(255,255,255) --reset  colors
    intro:drawTardis(window.width, window.height, startX, startY)
end

--[[
Draw Helpers
--]]
function intro:drawVortex(width, height)
	local startX = width / 2
    local startY = height * circleStartingPoint
    local endRadius = width / 2
    
    if height > width then
        endRadius = height / 2
    end

    local circleDropTime = (height - startY) / circleDY
    local circleDeltaRadius = (endRadius - circleRadius) / circleDropTime

    for i = 0, vortexLength do
		local yAddition = (height - startY) / vortexLength
        local actualY = (((circleDY * (currentAnimationTime)) + (yAddition * i)) % (height - startY)) + startY
        local radius = circleRadius + (circleDeltaRadius * (actualY - startY))
        local lineWidth = circleLineWidth + (circleDeltaLineWidth * (actualY - startY))

        local cr, cg, cb = intro:interpolateColour(
			0, 81, 211, 255,
			255, 255, 255, 255,
			(actualY - startY) / (height - startY)
		)

        love.graphics.setColor(cr, cg, cb)
        love.graphics.setLineWidth(lineWidth)
        love.graphics.circle('line', startX, actualY, radius, 64)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(255, 255, 255)
    end
    
    return startX, startY
end

function intro:drawTardis(width, height, startX, startY)
	local tardisScale = intro:interpolate(width / tardisImage:getHeight(), 0, currentAnimationTime / introAnimationLength)
    if tardisScale > 0 then
    	local tardisX = startX - (tardisImageHalfW * tardisScale)
    	local tardisY = intro:interpolate(height - (tardisImageQuarterH * tardisScale), startY - (tardisImageHalfH * tardisScale), currentAnimationTime /  introAnimationLength )
    	love.graphics.draw(tardisImage, tardisX, tardisY, 0, tardisScale, tardisScale)
    end
end

function intro:interpolateColour(
  r1, g1, b1, a1,
  r2, g2, b2, a2,
  delta)
    local r = intro:interpolate(r1, r2, delta)
    local g = intro:interpolate(g1, g2, delta)
    local b = intro:interpolate(b1, b2, delta)
    local a = intro:interpolate(a1, a2, delta)

    return r, g, b, a
end

function intro:interpolate(a, b, delta)
    return (a * (1 - delta)) + (b * delta)
end

--[[
Music Section
--]]

function intro:enter()
    camera:setPosition(0, 0)
    self.bg = love.audio.play("audio/theme.mp3", "stream", true)
end

function intro:leave()
    love.audio.stop(self.bg)
end

return intro