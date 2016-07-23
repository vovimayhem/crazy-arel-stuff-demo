class InboundOrder < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries
  has_many :inbound_order_transitions, autosave: false

  has_many :inbound_logs, inverse_of: :inbound_order
  has_many :inbound_shelves, through: :inbound_logs, source: :shelf

  def state_machine
    @state_machine ||= InboundOrderStateMachine.new(self, transition_class: InboundOrderTransition)
  end
  delegate :current_state, :trigger, :available_events, to: :state_machine

  def self.transition_class
    InboundOrderTransition
  end
  private_class_method :transition_class

  def self.initial_state
    :pending
  end
  private_class_method :initial_state

  def store_items!
    return unless current_state == "received"
    # Ejecuta el “INSERT”
    self.class.connection.insert store_items_insert_manager.to_sql
  end

  protected

    def store_items_insert_manager(timestamp = Time.now)
      items_table = Item.arel_table
      insert_manager = Arel::InsertManager.new
      insert_manager.into items_table
      insert_manager.columns.concat [ # Genera la lista de columnas del insert...
        items_table[:inbound_log_id],
        items_table[:product_id],
        items_table[:properties],
        items_table[:shelf_id],
        items_table[:rank],
        items_table[:created_at],
        items_table[:updated_at]
      ]

      insert_manager.select stored_items_projection # agrega el “SELECT”
      insert_manager
    end

    def stored_items_projection
      logs_table = InboundLog.arel_table

      # SQL: 'generate_series(1, "inbound_logs"."quantity")'
      item_sort = Arel::Nodes::NamedFunction
        .new("generate_series", [1, logs_table[:quantity]])

      timestamp = Time.now
      timestamp_literal = Arel::Nodes::SqlLiteral.new "'#{timestamp.to_s(:db)}'"

      # TODO: Bring in the solution used in RTS to get the rank right:
      logs_table
        .where(logs_table[:inbound_order_id].eq(id))
        .project logs_table[:id].as("\"inbound_log_id\""),
                 logs_table[:product_id],
                 logs_table[:properties],
                 logs_table[:shelf_id],
                 item_sort.as("\"rank\""),
                 timestamp_literal.as("\"created_at\""),
                 timestamp_literal.as("\"updated_at\"")
    end
end
