# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :incident, inverse_of: :location, dependent: :destroy
  validates :incident, presence: true

  # build an address from street, city, and state attributes
  geocoded_by :full_address,
              latitude: :latitude,
              longitude: :longitude

  # store the fetched address in the full_address attribute
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.full_address = geo.address
      obj.country = geo.country
      obj.state = geo.state
      obj.city = geo.city
      obj.street = geo.street
    end
  end

  before_validation :build_full_address

  after_validation :reverse_geocode, if: lambda { |obj|
    obj.latitude_changed? || obj.longitude_changed?
  }

  after_validation :geocode, if: lambda { |obj|
    obj.full_address.present? && obj.full_address_changed?
  }

  private

  def build_full_address
    self.full_address = [street, city, state, country].compact.join(', ')
  end
end
