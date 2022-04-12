# frozen_string_literal: true

class ComplaintSerializer < ActiveModel::Serializer
  attributes :id, :severity, :details

  belongs_to :user
end
