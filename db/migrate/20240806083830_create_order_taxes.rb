class CreateOrderTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_taxes do |t|
      t.references :order, null: false, foreign_key: true
      t.references :tax_type, null: false, foreign_key: true
      t.decimal :tax_amount

      t.timestamps
    end
  end
end
