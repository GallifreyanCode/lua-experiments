local Gamestate = require 'libs/gamestate'
--local logger = require 'util/logger'
local Level = require 'util/level'
local window = require 'gui/window'
local state = Gamestate.new()
local home = require 'gui/menu'

--loads all possible game states, includes all screens and levels
function state:init()
    state.finished = false
    state.current = 1
    state.assets = {}

    table.insert(state.assets, function()
        Gamestate.load('home', require 'gui/menu')
    end)

    state.step = 240 / # self.assets
end

function state:update(dt)
    if self.finished then
        return
    end

    local asset = state.assets[self.current]

    if asset ~= nil then
        asset()
        self.current = self.current + 1
    else
        self.finished = true
        Gamestate.switch('home')
    end
end

function state:draw()
    love.graphics.rectangle('line', 
                            window.width / 2 - 120,
                            window.height / 2 - 10,
                            240,
                            20)
    love.graphics.rectangle('fill', 
                            window.width / 2 - 120,
                            window.height / 2 - 10,
                            (self.current - 1) * self.step,
                            20)
end

return state