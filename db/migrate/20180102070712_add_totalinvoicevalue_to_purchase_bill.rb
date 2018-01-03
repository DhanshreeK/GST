class AddTotalinvoicevalueToPurchaseBill < ActiveRecord::Migration[5.1]
  def change
    add_column :purchase_bills, :total_invoice_value, :string
  end
end
