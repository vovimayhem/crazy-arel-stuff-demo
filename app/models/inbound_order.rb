class InboundOrder < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries
  has_many :inbound_order_transitions, autosave: false

  has_many :inbound_logs, inverse_of: :inbound_order
  has_many :inbound_shelves, through: :inbound_logs, source: :shelf

  def state_machine
    @state_machine ||= InboundOrderStateMachine
      .new self, transition_class: InboundOrderTransition
  end
  delegate :current_state, :trigger, :available_events, to: :state_machine

  def received?
    current_state == "received"
  end

  def pending?
    current_state == "pending"
  end

  def completed?
    current_state == "completed"
  end

  def store_items!
    InboundInventoryStorer.new(self).store_order_items!
  end

  class << self
    private
      def transition_class
        InboundOrderTransition
      end

      def initial_state
        :pending
      end


  end
end
