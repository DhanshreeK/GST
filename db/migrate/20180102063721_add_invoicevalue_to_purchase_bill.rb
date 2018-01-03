class AddInvoicevalueToPurchaseBill < ActiveRecord::Migration[5.1]
  def change
    add_column :purchase_bills, :invoice_value, :string
  end
end
