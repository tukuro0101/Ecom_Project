class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :sale_price, precision: 10, scale: 2
      t.date :sale_start_date
      t.date :sale_end_date
      t.integer :stock_quantity, null: false, default: 0
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
