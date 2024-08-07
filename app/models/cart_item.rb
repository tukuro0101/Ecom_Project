class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    product.price * quantity
  end

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  #at leat 1 cart item
end
