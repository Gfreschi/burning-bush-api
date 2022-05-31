# frozen_string_literal: true

class AddLatitudeAndLongitudeToComplaints < ActiveRecord::Migration[7.0]
  def change
    add_column :complaints, :latitude, :float, null: false
    add_column :complaints, :longitude, :float, null: false
  end
end
