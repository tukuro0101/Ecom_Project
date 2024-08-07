class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :street, :city, :province_id, :postal_code, :country, presence: true

  def full_address
    "#{street}, #{city}, #{province.name}, #{postal_code}, #{country}"
  end

  validates :street, :city, :province, :postal_code, :country, presence: true
  #so the filed aren't empty
  validates :country, inclusion: { in: ["Canada"], message: "%{value} is not a valid country" }
end
