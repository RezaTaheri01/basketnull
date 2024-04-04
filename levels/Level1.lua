Level1 = Class { __includes = BaseState }

function Level1:init()
    self.world = love.physics.newWorld(0, GRAVITY)

    self.ground = Ground(self.world, GROUND_HEIGHT)

    -- walls
    local leftWallBody = love.physics.newBody(self.world, 0, 0, 'static')
    local rightWallBody = love.physics.newBody(self.world, WINDOWS_WIDTH, 0, 'static')
    local wallShape = love.physics.newEdgeShape(0, 0, 0, WINDOWS_HEGHT)
    love.physics.newFixture(leftWallBody, wallShape)
    love.physics.newFixture(rightWallBody, wallShape)

    self.ball = Ball(self.world, WINDOWS_WIDTH - 362, WINDOWS_HEGHT / 2, BALL_RADIUS, BALL_BOUNCE, BALL_DAMPING)

    self.player1 = Player(self.world,
        WINDOWS_WIDTH - 350,
        WINDOWS_HEGHT - GROUND_HEIGHT - PLAYER_RADIUS,
        PLAYER_RADIUS, PLAYER_MASS, PLAYER_SPEED, PLAYER_JUMP, PLAYER_GSCALE,
        'left', 'right', 'up')

    self.basket = Basket(self.world, 400, 550, 150, 100)

    self.ballInBasketTimer = 0
end

function Level1:update(dt)
    self.world:update(dt)
    self.player1:update(dt)

    if self.basket:ballIsInside(self.ball) then
        self.ballInBasketTimer = self.ballInBasketTimer + dt
        if self.ballInBasketTimer > 3 then
            GameState:change('start')
        end
    else
        self.ballInBasketTimer = 0
    end
end

function Level1:render()
    self.ground:render()
    self.ball:render()
    self.player1:render()
    self.basket:render()
    love.graphics.setColor(.5, 1, 0)
    if self.ballInBasketTimer > 0 then
        love.graphics.printf(math.ceil(3 - self.ballInBasketTimer),
            self.basket.body:getX() - self.basket.width / 2, self.basket.body:getY() - 6,
            self.basket.width, 'center')
    end
    love.graphics.setColor(WHITE)
end
