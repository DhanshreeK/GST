class AddTaxrateToPurchaseBill < ActiveRecord::Migration[5.1]
  def change
    add_column :purchase_bills, :tax_rate, :string
  end
end
