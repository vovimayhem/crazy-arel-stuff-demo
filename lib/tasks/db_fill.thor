require "thor/rails"

class DbFill < Thor
  include Thor::Rails

  desc "add_categories", "Generates dummy product categories"
  def add_categories
    ask("How many new categories would you wish to add?").to_i.times.map do |a|
      Category.create name: FFaker::Product.product_name
    end
  end

  desc "add_products", "Generates dummy products"
  def add_products
    add_categories unless Category.any?

    # Fill a list of category ids we can randomly select while creating products:
    category_ids = Category.pluck :id

    ask("How many new products would you wish to add?").to_i.times.each do
      random_index = SecureRandom.random_number(category_ids.count - 1)
      Product.create category_id: category_ids[random_index],
                     name: FFaker::Product.product,
                     brand: FFaker::Product.brand
    end
  end

  desc "add_shelves", "Generates dummy shelves"
  def add_shelves
    ask("How many new shelves would you wish to add?").to_i.times.each do
      Shelf.create name: FFaker::DizzleIpsum.characters(5)
    end
  end

  desc "add_inventory", "Generates dummy inventory for testing..."
  def add_inventory
    add_shelves unless Shelf.any?
    add_products unless Product.any?

    # Fill a list of product ids we can randomly select while creating inbound logs:
    shelf_ids = Shelf.pluck :id
    product_ids = Product.pluck :id

    line_count = ask("How many different products you wish to add to the order?").to_i
    requested_quantity = ask("How many items do you want per product?").to_i

    inbound_order = InboundOrder.create notes: "Created by the dummy data filler"

    line_count.times.each do
      random_shelf_id = shelf_ids[SecureRandom.random_number(shelf_ids.count - 1)]
      random_product_id = product_ids[SecureRandom.random_number(product_ids.count - 1)]
      inbound_order.inbound_logs.create shelf_id: random_shelf_id,
                                        product_id: random_product_id,
                                        quantity: requested_quantity,
                                        properties: { size: SecureRandom.random_number(100) }
    end

    inbound_order.trigger :receive
    inbound_order.trigger :complete
  end
end
