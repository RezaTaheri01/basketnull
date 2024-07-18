Level16 = Class { __includes = BaseLevel }

Level16.designer = "Mitinull"

function Level16.init(self, onWin)
    BaseLevel.init(self, onWin)

    self.ball = Ball(self.world, 1000, VIRTUAL_HEIGHT / 2 - 350, BALL_RADIUS, 1.01, BALL_DAMPING, COLOR9)

    self.player1 = PlayerMediumRed(self.world,
        VIRTUAL_WIDTH - 1150,
        VIRTUAL_HEIGHT - GROUND_HEIGHT - PlayerMediumRed.radius, 'left', 'right', 'up')

    self.basket = Basket(self.world, 1000, VIRTUAL_HEIGHT - GROUND_HEIGHT - 200, 400, 150)

    self.lines = Lines(self.world, {
        { 0, 275, VIRTUAL_WIDTH, 275 },
    })
end

function Level16.update(self, dt)
    BaseLevel.update(self, dt)
    self.player1:update(dt)
end

function Level16:render()
    BaseLevel.render(self)
    love.graphics.setColor(COLOR3)
    love.graphics.setFont(FontPrimaryMedium)
    love.graphics.printf(
        'EASY?', 0,
        VIRTUAL_HEIGHT / 2 - 350, VIRTUAL_WIDTH, 'center')
    self.lines:render()
    self.ball:render()
    self.player1:render()
    self.basket:render()
    love.graphics.setColor(WHITE)
    BaseLevel.renderCountDown(self)
end
