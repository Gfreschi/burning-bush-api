class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :incident, null: false, foreign_key: true
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :full_address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
