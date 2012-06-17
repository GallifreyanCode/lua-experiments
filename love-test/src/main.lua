local http=require'socket.http'

function love.load()
   hamster = love.graphics.newImage("img/hamster.png")
   x = 50
   y = 50
   speed = 100
   Tileset = love.graphics.newImage('img/countryside.png')
  
  local tileW, tileH = 32,32
  local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
  GrassQuad = love.graphics.newQuad(0,  0, tileW, tileH, tilesetW, tilesetH)
  BoxQuad = love.graphics.newQuad(32, 0, tileW, tileH, tilesetW, tilesetH)
end

function love.update(dt)
   if love.keyboard.isDown("right") then
      x = x + (speed * dt)
   elseif love.keyboard.isDown("left") then
      x = x - (speed * dt)
   end

   if love.keyboard.isDown("down") then
      y = y + (speed * dt)
   elseif love.keyboard.isDown("up") then
      y = y - (speed * dt)
   end
   
   if love.keyboard.isDown("return") then
		body,c,l,h = http.request('http://w3.impa.br/~diego/software/luasocket/http.html')
		print('status line',l)
	end
end

function love.draw()
   love.graphics.draw(hamster, x, y)
   love.graphics.drawq(Tileset, GrassQuad, 368, 268)
  love.graphics.drawq(Tileset, GrassQuad, 400, 268)
  love.graphics.drawq(Tileset, GrassQuad, 432, 268)
  love.graphics.drawq(Tileset, GrassQuad, 368, 300)
  love.graphics.drawq(Tileset, BoxQuad  , 400, 300)
  love.graphics.drawq(Tileset, GrassQuad, 432, 300)
  love.graphics.drawq(Tileset, GrassQuad, 368, 332)
  love.graphics.drawq(Tileset, GrassQuad, 400, 332)
  love.graphics.drawq(Tileset, GrassQuad, 432, 332)
end