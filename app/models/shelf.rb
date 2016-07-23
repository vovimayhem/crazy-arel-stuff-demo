class Shelf < ApplicationRecord
  has_many :items
  has_many :products, -> { distinct }, through: :items
end
