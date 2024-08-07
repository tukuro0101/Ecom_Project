class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :reviews
  has_many :cart_items
  has_many :sales
  has_many_attached :images

  has_one_attached :image
  scope :on_sale, -> { where.not(sale_price: nil) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }

  validates :name, :description, :price, presence: true
  #info are filled
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  #valid price
  validates :sale_price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def on_sale?
    sale_price.present? && sale_start_date <= Time.current && sale_end_date >= Time.current
  end
end
