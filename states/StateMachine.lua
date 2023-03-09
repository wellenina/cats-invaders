StateMachine = {}

StateMachine.currentState = {}

function StateMachine:changeState(newState, selection)
    self.currentState = newState
    self.currentState:load(selection)
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end