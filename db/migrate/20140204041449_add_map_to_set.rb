class AddMapToSet < ActiveRecord::Migration
  def change
  	add_column :photo_sets, :map, :string
  end
end
