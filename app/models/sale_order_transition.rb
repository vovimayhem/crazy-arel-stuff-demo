# SaleOrder transition model generated by Statesman:
class SaleOrderTransition < ActiveRecord::Base
  belongs_to :sale_order, inverse_of: :sale_order_transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = sale_order.sale_order_transitions.order(:sort_key).last
    return unless last_transition.present?
    last_transition.update_column(:most_recent, true)
  end
end
