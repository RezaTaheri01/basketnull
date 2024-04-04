PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.levels = {
        [1] = Level1,
        [2] = Level2,
        [3] = Level3,
        [4] = Level4,
        [5] = Level5,
    }

    self.countDown = 1.5
end

function PlayState:enter(level)
    self.levelNumber = level
    self.level = self.levels[level]()
end

function PlayState:update(dt)
    if self.countDown > 0 then
        self.countDown = self.countDown - dt
    else
        self.level:update(dt)
    end


    if love.keyboard.wasPressed('r') then
        GameState:change('play', self.levelNumber)
    end

    if love.keyboard.wasPressed('escape') then
        GameState:change('start', self.levelNumber)
    end
end

function PlayState:render()
    self.level:render()
    if self.countDown > 0 then
        love.graphics.setColor(0, 0, 0, .5)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(COUNTDOWN_COLOR)
        love.graphics.setFont(FontPrimaryLarge)
        love.graphics.printf(math.ceil(self.countDown * 2), 0, VIRTUAL_HEIGHT / 2 - 128, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(WHITE)
    end

    love.graphics.setColor(COLOR3)
    love.graphics.setFont(FontPrimarySmall)
    love.graphics.printf('Menu[escape]', 0, 40, VIRTUAL_WIDTH - 60, 'right')
    love.graphics.setFont(FontPrimaryMedium)
    love.graphics.printf('Reset[r]', 0, 120, VIRTUAL_WIDTH - 60, 'right')
end
