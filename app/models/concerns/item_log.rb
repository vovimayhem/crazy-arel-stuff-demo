module ItemLog
  extend ActiveSupport::Concern

  included do
    belongs_to :product, required: true

    validates :quantity,
              presence: true,
              numericality: { only_integer: true, greater_than: 0 }

  end
end
