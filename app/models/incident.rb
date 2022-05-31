# frozen_string_literal: true

class Incident < ApplicationRecord
  has_many :complaints, dependent: :destroy
end
