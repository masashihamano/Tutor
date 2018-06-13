class AddLatitudeAndLongitudeToSharing < ActiveRecord::Migration[5.2]
  def change
    add_column :sharings, :latitude, :float
    add_column :sharings, :longitude, :float
  end
end
