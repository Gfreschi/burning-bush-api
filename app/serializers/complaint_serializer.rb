# frozen_string_literal: true

class ComplaintSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :severity, :details, :latitude, :longitude, :kind, :associated_incident, :image, :created_at

  def associated_incident
    object&.incident&.present?
  end

  def image
    return unless object.image.attached?

    object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: image_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def image_url
    rails_blob_url(object.image)
  end
end
