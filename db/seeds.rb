require 'faker'

provinces = [
  { name: 'Alberta' },
  { name: 'British Columbia' },
  { name: 'Manitoba' },
  { name: 'New Brunswick' },
  { name: 'Newfoundland and Labrador' },
  { name: 'Northwest Territories' },
  { name: 'Nova Scotia' },
  { name: 'Nunavut' },
  { name: 'Ontario' },
  { name: 'Prince Edward Island' },
  { name: 'Quebec' },
  { name: 'Saskatchewan' },
  { name: 'Yukon' }
]

provinces.each do |province|
  Province.find_or_create_by(name: province[:name])
end

# Tax Types
tax_types = [
  { name: 'GST' },
  { name: 'PST' },
  { name: 'HST' },
  { name: 'QST' }
]

tax_types.each do |tax_type|
  TaxType.find_or_create_by(name: tax_type[:name])
end

# Taxes
taxes = [
  { province: 'Alberta', tax_type: 'GST', rate: 5 },
  { province: 'British Columbia', tax_type: 'GST', rate: 5 },
  { province: 'British Columbia', tax_type: 'PST', rate: 7 },
  { province: 'Manitoba', tax_type: 'GST', rate: 5 },
  { province: 'Manitoba', tax_type: 'PST', rate: 7 },
  { province: 'New Brunswick', tax_type: 'HST', rate: 15 },
  { province: 'Newfoundland and Labrador', tax_type: 'HST', rate: 15 },
  { province: 'Northwest Territories', tax_type: 'GST', rate: 5 },
  { province: 'Nova Scotia', tax_type: 'PST', rate: 15 },
  { province: 'Nunavut', tax_type: 'GST', rate: 5 },
  { province: 'Ontario', tax_type: 'PST', rate: 13 },
  { province: 'Prince Edward Island', tax_type: 'PST', rate: 15 },
  { province: 'Quebec', tax_type: 'GST', rate: 5 },
  { province: 'Quebec', tax_type: 'QST', rate: 9.975 },
  { province: 'Saskatchewan', tax_type: 'GST', rate: 5 },
  { province: 'Saskatchewan', tax_type: 'PST', rate: 6 },
  { province: 'Yukon', tax_type: 'GST', rate: 5 }
]

taxes.each do |tax|
  province = Province.find_by(name: tax[:province])
  tax_type = TaxType.find_by(name: tax[:tax_type])
  Tax.find_or_create_by(province: province, tax_type: tax_type, rate: tax[:rate], effective_date: Date.today)
end

# Create Categories
categories = ["Figurines", "Posters", "Clothing", "Accessories"]
categories.each do |category|
  Category.find_or_create_by(name: category)
end

# Create Products
100.times do
  Product.create(
    name: Faker::JapaneseMedia::OnePiece.character,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 100),
    category: Category.all.sample
  )
end


# Create an admin user
User.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'ad@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: 'admin'
)
ContactPage.create(title: 'Contact Us', content: 'This is the contact page.')
AboutPage.create(title: 'About Us', content: 'This is the about page.')

