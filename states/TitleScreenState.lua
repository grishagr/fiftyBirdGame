--[[
    TitleScreenState Class
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The TitleScreenState is the starting screen of the game, shown on startup. It should
    display "Press Enter" and also our highest score.
]]

TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
    self.name = 'title'
    self.bird = Bird()
end

function TitleScreenState:update(dt)
    gScrolling = true
    self.bird:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Space', 0, 100, VIRTUAL_WIDTH, 'center')
    self.bird:render()
end