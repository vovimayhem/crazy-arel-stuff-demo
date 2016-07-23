class OutboundLog < ApplicationRecord
  belongs_to :sale_order, required: true
  includes ItemLog
end
