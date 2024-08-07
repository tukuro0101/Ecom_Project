class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :sale_price:decimal, precision: 10, scale: 2
      t.date :sale_start_date
      t.date :sale_end_date

      t.timestamps
    end
  end
end
