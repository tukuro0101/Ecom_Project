class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def total_price
    cart_items.inject(0) { |sum, item| sum + item.total_price }
  end
end
