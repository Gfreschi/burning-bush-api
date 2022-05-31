class IncidentSerializer < ActiveModel::Serializer
  attributes :id

  has_many :complaints
end
