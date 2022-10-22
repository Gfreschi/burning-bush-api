# frozen_string_literal: true

class Incident < ApplicationRecord
  has_many :complaints, dependent: :nullify
  has_one :location, dependent: :destroy
  accepts_nested_attributes_for :location

  validates :location, presence: true
  validates :complaints, presence: true

  delegate :coordinates, to: :location
  delegate :latitude, :longitude, to: :location
  delegate :full_address, to: :location

  scope :near_incidents, lambda { |latitude, longitude, distance_in_kilometers = 2|
    joins(:location)
      .merge(Location.near_coordinates(latitude, longitude, distance_in_kilometers))
      .select('incidents.*, locations.latitude, locations.longitude')
  }
end
