class AddColumnsToExportPurchaseBills < ActiveRecord::Migration[5.1]
  def change
    add_column :export_purchase_bills, :bill_type, :string
    add_column :export_purchase_bills, :transportation_mode, :string
    add_column :export_purchase_bills, :vehicle_number, :string
    add_column :export_purchase_bills, :rcm, :string
    add_column :export_purchase_bills, :terms_and_conditions, :string
    add_column :export_purchase_bills, :narration, :string
  end
end
