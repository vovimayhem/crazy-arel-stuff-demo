class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include SortableByGivenScores

  belongs_to :category
  has_many :products, inverse_of: :category

  scope :categories, -> { Category.joins(:products).merge(current_scope).distinct }

  class << self
    def ar_search(*args)
      scores = search(*args).response.hits.hits.map do |hit|
        { id: hit._id.to_i, score: hit._score }
      end
      by_given_scores scores
    end
  end
end
