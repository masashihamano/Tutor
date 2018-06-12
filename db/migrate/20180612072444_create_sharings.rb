class CreateSharings < ActiveRecord::Migration[5.2]
  def change
    create_table :sharings do |t|
      t.string :home_type
      t.string :pet_type
      t.string :pet_size
      t.integer :breeding_years
      t.string :address
      t.string :sharing_title
      t.text :sharing_content
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
