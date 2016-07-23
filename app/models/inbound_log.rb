class InboundLog < ApplicationRecord
  belongs_to :inbound_order, required: true
  belongs_to :shelf, required: false
  includes ItemLog

  has_many :items

  scope :without_shelf, -> { where shelf_id: nil }
end
