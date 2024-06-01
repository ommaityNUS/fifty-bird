--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

medals = {
    ['bronze'] = love.graphics.newImage('bronze.png'),
    ['silver'] = love.graphics.newImage('silver.png'),
    ['gold'] = love.graphics.newImage('gold.png')
}

medalHeight = 32
medalWidth = 32

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- render medals after score text
    if self.score <= 1 then
        love.graphics.printf("You've Gotten Bronze!", 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(medals["bronze"], (VIRTUAL_WIDTH - medalWidth)/2, 140)
    elseif self.score == 2 then
        love.graphics.printf("You've Gotten Silver!", 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(medals["silver"], (VIRTUAL_WIDTH - medalWidth)/2, 140)
    elseif self.score >=3 then
        love.graphics.printf("You've Gotten Gold!", 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(medals["gold"], (VIRTUAL_WIDTH - medalWidth)/2, 140)
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 180, VIRTUAL_WIDTH, 'center')
end