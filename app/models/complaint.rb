# frozen_string_literal: true

class Complaint < ApplicationRecord
  belongs_to :user

  enum kind: { burn: 0, trash: 1 }

  validates :user, presence: true
end
