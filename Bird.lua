Bird = Class{}

local image0 = love.graphics.newImage('bird.png')
local image1 = love.graphics.newImage('bird1.png')
local image2 = love.graphics.newImage('bird2.png')
local images = {[0] = image0, [1]= image1, [2] = image2}

local JUMP = -6
local GRAVITY = 20
local ROTATION_SPEED = 6
local ROTATION_JUMP = 7
local bird_state = 1
local WING_SPEED = 7 -- 1 is fastest, 2 is slower, 3 is even slower...


function Bird:init()

    -- states of birds
    self.images = images

    -- bird size parameters
    self.width = self.images[1]:getWidth() -- 38
    self.height = self.images[1]:getHeight() -- 24
    self.radius = math.min(self.width / 2, self.height / 2) -- 12
    

    -- starting position
    self.x = VIRTUAL_WIDTH / 2 
    self.y = VIRTUAL_HEIGHT / 2

    -- initialization of bird's velocity and direction
    self.rotation = 0
    self.dy = -6
end

function Bird:update(dt)

    bird_state = bird_state + 1/WING_SPEED

    if gStateMachine:active() == 'play' then
        if love.keyboard.wasPressed('space') then
            self.dy = JUMP
            self.rotation = -math.pi / ROTATION_JUMP
            sounds['jump']:play()
        end
        if self.rotation < math.pi / 2 and self.dy > 5 then
            self.rotation = self.rotation + dt * ROTATION_SPEED
        end
    end

    if gStateMachine:active() == 'title' then
        self.dy =  math.cos(bird_state)
    else
        self.dy = self.dy + GRAVITY * dt
    end

    self.y = self.y + self.dy
end 

function Bird:collides(object)
    --center coordinates for object
    objectCenterX = object.x + object.width / 2
    objectCenterY = object.y + object.height / 2

    centerDistanceX = math.abs(self.x - objectCenterX)
    centerDistanceY = math.abs(self.y - objectCenterY)

    if centerDistanceX > (object.width / 2 + self.radius) or centerDistanceY > (object.height / 2 + self.radius) then
        return false
    end

    if centerDistanceX < (object.width /2) or centerDistanceY < (object.height / 2) then
        return true
    end

    cornerDistanceSquared = (centerDistanceX - object.width / 2)^ (2) + (centerDistanceY - object.height / 2) ^ (2)
    return cornerDistanceSquared <= self.radius ^ (2)
end

function Bird:render()
    if gStateMachine:active() == 'play' then
        i = math.floor(bird_state) % 3
    love.graphics.draw(self.images[i], self.x, self.y, self.rotation, 1, 1, self.width / 2, self.height / 2)
    elseif gStateMachine:active() == 'title' then
        love.graphics.draw(self.images[0], self.x, self.y, self.rotation, 1, 1, self.width / 2, self.height / 2)
    else
        love.graphics.draw(self.images[2], self.x, self.y, self.rotation, 1, 1, self.width / 2, self.height / 2)
    end
end