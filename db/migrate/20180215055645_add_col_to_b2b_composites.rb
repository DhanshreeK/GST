class AddColToB2bComposites < ActiveRecord::Migration[5.1]
  def change
    add_column :b2b_composites, :supply_type, :string
  end
end
