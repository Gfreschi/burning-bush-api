# frozen_string_literal: true

class IncidentSerializer < ActiveModel::Serializer
  attributes :id, :title, :severity, :kind, :details, :created_at

  has_many :complaints
end
