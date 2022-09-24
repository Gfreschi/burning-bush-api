# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :incident

  validates :latitude, presence: true
  validates :longitude, presence: true

  with_options if: :address do
    validates :address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :country, presence: true

    geocoded_by :address
    after_validation :geocode
  end

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def coordinates
    [latitude, longitude]
  end

  def address
    [street, city, state, country].compact.join(', ')
  end
end