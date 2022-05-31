# frozen_string_literal: true

class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.string :title
      t.integer :severity
      t.integer :kind
      t.string :details

      t.timestamps
    end
  end
end
