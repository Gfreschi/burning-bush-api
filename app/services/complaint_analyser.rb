# frozen_string_literal: true

require 'decisiontree'

# WIP
# This service analyse a complaint and create a new incident if necessary
# discrete values are values that you know the possible values of
# in this case, we know the possible values of the 'img_attached?' and 'kind' attributes
# but we don't know the possible values of the 'details' attribute
# so we don't include it in the list of discrete values
class ComplaintAnalyser
  def initialize(complaint)
    @complaint = complaint
  end

  def self.call(complaint)
    new(complaint).send(:execute)
  end

  attr_accessor :complaint, :tree

  def execute
    build_tree_and_train
    analyse_complaint
  end

  def build_complaint_array
    [
      complaint.details.to_s.length,
      complaint.kind.present? ? 1 : 0,
      complaint.image.attached? ? 1 : 0,
      complaint.user.confirmed? ? 1 : 0
    ]
  end

  def build_tree_and_train
    attributes = ['DETAILS_LENGTH', 'KIND?', 'IMAGE?', 'USER_CONFIRMED?']

    training = [
      [5, 1, 1, 1, 1],
      [6, 1, 0, 1, 1],
      [0, 1, 0, 1, 0],
      [0, 0, 1, 1, 0]
      # more cases
    ]

    # Instantiate the tree, and train it based on the data (set default to 1)
    @tree = DecisionTree::ID3Tree.new(attributes, training, 1, :discrete)
    tree.train
  end

  def analyse_complaint
    return unless tree.predict(build_complaint_array) == 1

    IncidentGenerator.call(complaint)
  end
end
