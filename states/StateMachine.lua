StateMachine = {}

StateMachine.currentState = {}

function StateMachine:changeState(newState)
    self.currentState = newState
    self.currentState:load()
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end