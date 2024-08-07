class TaxRate < ApplicationRecord
  belongs_to :province
  belongs_to :tax_type
end