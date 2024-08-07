class OrderTax < ApplicationRecord
  belongs_to :order
  belongs_to :tax_type
end
