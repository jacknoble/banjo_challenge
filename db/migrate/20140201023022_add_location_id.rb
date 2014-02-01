class AddLocationId < ActiveRecord::Migration
  def change
  	add_column :photos, :location_id, :integer
  end
end
