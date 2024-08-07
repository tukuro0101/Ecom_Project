class User < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :reviews
  has_one :cart
  def admin?
    role == 'admin'
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :admins, -> { where(admin: true) }

  accepts_nested_attributes_for :addresses

  attr_accessor :first_name, :last_name, :street, :city, :province, :postal_code, :country

  validates :first_name, :last_name, presence: true
   #so the filed aren't empty
end
