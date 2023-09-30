PipePair = Class{}

local PIPE_SCROLL = -60

local GAP_HEIGHT = 110

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 20
    self.y = y
    self.pipes = {['upper'] = Pipe('top', self.y),
    ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)}
    self.removed = false
    self.scored = false
end 

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
        self.x = self.x + PIPE_SCROLL * dt
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do 
        pipe:render()
    end
end