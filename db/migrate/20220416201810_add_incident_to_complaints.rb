class AddIncidentToComplaints < ActiveRecord::Migration[7.0]
  def change
    add_reference :complaints, :incident, null: true, foreign_key: true
  end
end
