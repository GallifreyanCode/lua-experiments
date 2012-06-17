local Logger = require 'util/logger'
local Queue = require 'util/queue'
local Gamestate = require 'libs/gamestate'
local anim8 = require 'libs/anim8'
local atl = require 'libs/AdvTiledLoader'
local HC = require 'libs/hardoncollider'
local Timer = require 'libs/timer'
local camera = require 'util/camera'
local window = require 'gui/window'
-- cache
local node_cache = {}
local tile_cache = {}

function load_tileset(name)
    if tile_cache[name] then
        return tile_cache[name]
    end

    local tileset = atl.Loader.load(name)
    tile_cache[name] = tileset
    return tileset
end

function load_element(name)
    if node_cache[name] then
        return node_cache[name]
    end

    local node = require('elements/' .. name)
    node_cache[name] = node
    return node
end