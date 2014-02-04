class AddSetIdToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos, :set_id, :integer
  	add_index :photos, :set_id
  end
end
