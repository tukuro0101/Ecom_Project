class CreateTaxRates < ActiveRecord::Migration[6.1]
  def change
    create_table :tax_rates do |t|
      t.references :province, null: false, foreign_key: true
      t.references :tax_type, null: false, foreign_key: true
      t.decimal :rate

      t.timestamps
    end
  end
end
