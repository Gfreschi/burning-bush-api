# frozen_string_literal: true

class CreateComplaints < ActiveRecord::Migration[7.0]
  def change
    create_table :complaints do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :severity
      t.string :details
      t.integer :kind

      t.timestamps
    end
  end
end
