class RequestStateMachine
    include Statesman::Machine
    
        state :raised, initial: true
        state :accepted
        state :purchased
        state :sent
        state :received
        state :remitted
        state :enquete

        transition from: :raised, to: :accepted
        transition from: :accepted, to: :purchased
        transition from: :purchased, to: :sent
        transition from: :sent, to: :received
        transition from: :received, to: :remitted
        transition from: :remitted, to: :enquete
    
end

  