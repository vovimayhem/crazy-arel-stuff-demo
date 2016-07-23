class Product < ApplicationRecord
  belongs_to :category
  has_many :products, inverse_of: :category
end
