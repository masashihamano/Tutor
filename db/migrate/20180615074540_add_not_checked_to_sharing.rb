class AddNotCheckedToSharing < ActiveRecord::Migration[5.2]
  def change
    add_column :sharings, :not_checked, :integer
  end
end
