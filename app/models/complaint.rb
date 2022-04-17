# frozen_string_literal: true

class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :incident, optional: :true

  enum kind: { burn: 0, trash: 1 }

  validates :user, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

end
