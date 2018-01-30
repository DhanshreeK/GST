class AddColumnsToCompositeCdNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :composite_cd_notes, :service_code, :string
  end
end
