# frozen_string_literal: true

class Incident < ApplicationRecord
  has_many :complaints, dependent: :nullify
  has_one :location, dependent: :destroy

  validates :location, presence: true
  validates :complaints, presence: true

  delegate :latitude, :longitude, to: :location
  delegate :address, to: :location

  def kind
    complaints.first.kind
  end
end
