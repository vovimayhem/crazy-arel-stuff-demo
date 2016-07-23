class InboundOrderStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :pending, initial: true
  state :received
  state :stored

  transition from: :pending,  to: :received
  transition from: :received, to: :stored

  guard_transition(to: :received) do |order|
    order.inbound_logs.any?
  end

  guard_transition(to: :stored) do |order|
    order.inbound_logs.without_shelf.empty?
  end

  before_transition(to: :stored) do |order, transition|
    order.store_items!
  end

  event :receive do
    transition from: :pending, to: :received
  end

  event :finish do
    transition from: :received, to: :stored
  end
end
