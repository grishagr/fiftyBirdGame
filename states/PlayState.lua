--[[
    PlayState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The PlayState class is the bulk of the game, where the player actually controls the bird and
    avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
    we then go back to the main menu.
]]

PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

gscrolling = true

local escKey = love.graphics.newImage('esc.png')
local GAP = 3

function PlayState:enter(params)
    self.name = 'play'
    if params == nil then
        self.bird = Bird()
        self.pipePairs = {}
        self.score = 0
        self.timer = 0
        -- initialize our last recorded Y value for a gap placement to base other gaps off of
        self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    else
        self.pipePairs = params.pipePairs
        self.bird = params.bird
        self.score = params.score
        self.lastY = params.lastY
        self.timer = params.timer
    end
end

function PlayState:update(dt)
    gScrolling = true
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('pause', {score = self.score, bird = self.bird, pipePairs = self.pipePairs, timer = self.timer, lastY = self.lastY})
    end
    -- update timer for pipe spawning
    self.timer = self.timer + dt

    -- spawn a new pipe pair every second and a half
    if self.timer > GAP then
        -- modify the last Y coordinate we placed so pipe gaps aren't too far apart
        -- no higher than 10 pixels below the top edge of the screen,
        -- and no lower than a gap length (90 pixels) from the bottom
        local y = math.max(-PIPE_HEIGHT + 10, 
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        -- add a new pipe pair at the end of the screen at our new Y
        table.insert(self.pipePairs, PipePair(y))

        -- reset timer
        self.timer = 0
    end

    -- for every pair of pipes..
    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + PIPE_WIDTH < (self.bird.x - self.bird.width / 2) then
                self.score = self.score + 1
                pair.scored = true
                sounds['score']:play()
            end
        end
        -- update position of pair
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    -- simple collision between bird and all pipes in pairs
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('score', {score = self.score, bird = self.bird, pipePairs = self.pipePairs})
                sounds['hurt']:play()
                
            end
        end
    end

    -- update bird based on gravity and input
    self.bird:update(dt)

    -- reset if we get to the ground
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('score', {score = self.score, bird = self.bird, pipePairs = self.pipePairs})
    end

end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: '.. tostring(self.score), 8, 8)
    love.graphics.setFont(smallfont)
    love.graphics.draw(escKey, VIRTUAL_WIDTH - 80, 12)
    love.graphics.print('Menu', VIRTUAL_WIDTH - 55, 16)
    self.bird:render()
end