class Province < ApplicationRecord
    has_many :addresses
    has_many :taxes
  end
  