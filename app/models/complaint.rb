# frozen_string_literal: true

class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :incident, optional: true

  # enum kind: { burn: 0, trash: 1 }

  validates :user, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_one_attached :image

  reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode

  after_create :generate_incident

  def generate_incident
    ::IncidentGenerator.call(self)
  end

  def coordinates
    [latitude, longitude]
  end
end
