class Item < ApplicationRecord
  belongs_to :inbound_log, required: true
  belongs_to :outbound_log, required: false
  belongs_to :product, required: true
end
