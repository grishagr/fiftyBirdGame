PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.score = params.score
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    self.lastY = params.lastY
    
end

function PauseState:update(dt)
    gScrolling = false
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play', {score = self.score, bird = self.bird, pipePairs = self.pipePairs, timer = self.timer, lastY = self.lastY})
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    

end

function PauseState:render()
    -- simply render the score to the middle of the screen
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    self.bird:render()

    love.graphics.setFont(pauseFont)
    love.graphics.printf('||', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.draw(spacebarKey, 160, 155)
    love.graphics.print('Score: '.. tostring(self.score), 8, 8)
    love.graphics.printf('Continue', 0, 160, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(escKey, 180, 180)
    love.graphics.printf('Quit Game', 0, 185, VIRTUAL_WIDTH, 'center')
end