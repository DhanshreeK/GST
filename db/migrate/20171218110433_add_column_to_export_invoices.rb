class AddColumnToExportInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :export_invoices, :export_invoice_value, :string
  end
end
