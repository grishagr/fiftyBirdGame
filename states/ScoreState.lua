ScoreState = Class{__includes = BaseState}

local enterKey = love.graphics.newImage('enter.png')
local escKey = love.graphics.newImage('esc.png')

function ScoreState:init()
    self.name = 'score'
end

function ScoreState:enter(params)
    self.score = params.score
    self.bird = params.bird
    self.pipePairs = params.pipePairs
end

function ScoreState:update(dt)
    gScrolling = false
    self.bird.dy = 10
    self.bird.rotation = math.pi / 2
    self.bird:update(dt)
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        self.bird.y = VIRTUAL_HEIGHT - 15
    end
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    self.bird:render()

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.draw(enterKey, 180, 160)    
    love.graphics.printf('Restart', 0, 160, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(escKey, 190, 195)
    love.graphics.printf('Quit Game', 0, 200, VIRTUAL_WIDTH, 'center')

    
end