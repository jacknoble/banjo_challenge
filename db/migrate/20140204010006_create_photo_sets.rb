class CreatePhotoSets < ActiveRecord::Migration
  def change
    create_table :photo_sets do |t|
      t.string :location
      t.string :lat
      t.string :lng
      t.string :radius

      t.timestamps
    end

    remove_column :photos, :location_id
    remove_column :photos, :location_name
  end
end
