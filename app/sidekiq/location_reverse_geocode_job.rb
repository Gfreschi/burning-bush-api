# frozen_string_literal: true

# This job is used to reverse geocode a location
# and update the location with the results.

# TODO: Need to configure redis and sidekiq
require 'sidekiq'
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sikideq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

class LocationReverseGeocodeJob
  include Sidekiq::Job

  queue :high

  def perform(location_id)
    location = Location.find(location_id)
    address = address(location)

    location.update(address:) if address.present?
  end

  private

  def address(location)
    Geocoder.address(location.coordinates)
  rescue StandardError => e
    MonitoringService.notify(e, location: { id: location.id })

    raise e if retryable?(e)
  end

  def retryable?(exception)
    exception.is_a?(Timeout::Error) || exception.is_a?(SocketError)
  end
end
