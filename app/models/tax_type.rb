class TaxType < ApplicationRecord
    has_many :taxes
    has_many :order_taxes
  end
  