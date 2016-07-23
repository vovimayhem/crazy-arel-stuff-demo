FactoryGirl.define do
  factory :inventory_item do
    inbound_product_log nil
    product nil
    properties ""
    sale_order nil
  end
end
