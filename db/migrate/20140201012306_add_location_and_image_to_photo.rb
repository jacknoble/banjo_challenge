class AddLocationAndImageToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos, :location_name, :string
  	add_column :photos, :image, :string
  end
end
