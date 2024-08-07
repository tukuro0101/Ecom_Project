class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :order_taxes, dependent: :destroy

  attr_accessor :new_address

  before_validation :assign_new_address

  enum status: { pending: 0, completed: 1, canceled: 2 }

  def calculate_subtotal
    order_items.sum('quantity * price')
  end

  def calculate_taxes
    province = address.province
    applicable_taxes = province.taxes
    total_taxes = {}

    applicable_taxes.each do |tax|
      tax_amount = calculate_subtotal * (tax.rate / 100.0)
      order_taxes.build(tax_type: tax.tax_type, tax_amount: tax_amount, tax_rate: tax.rate)
      total_taxes[tax.tax_type.name] ||= 0
      total_taxes[tax.tax_type.name] += tax_amount
    end

    total_taxes
  end

  def calculate_total
    calculate_subtotal + calculate_taxes
  end

  private

  def assign_new_address
    if new_address.present?
      self.address = user.addresses.create(new_address)
    end
  end
end
