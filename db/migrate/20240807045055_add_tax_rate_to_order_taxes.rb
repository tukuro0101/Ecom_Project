class AddTaxRateToOrderTaxes < ActiveRecord::Migration[6.1]
  def change
    add_column :order_taxes, :tax_rate, :decimal
  end
end
