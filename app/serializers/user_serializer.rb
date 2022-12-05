# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar

  has_many :complaints

  def avatar
    return unless object.image.attached?

    object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: avatar_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def image_url
    rails_blob_url(object.image)
  end
end
