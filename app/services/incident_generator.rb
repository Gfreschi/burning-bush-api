# frozen_string_literal: true

# This service create a new incident for each complaint
class IncidentGenerator
  def initialize(complaint)
    @complaint = complaint
  end

  def self.call(complaint)
    new(complaint).send(:generate)
  end

  private

  attr_accessor :complaint

  def generate
    ActiveRecord::Base.transaction do
      generate_incident
      update_complaint
    end
  end

  def build_attributes
    {
      title: 'INCIDENT AUTOGENERATED',
      complaints: [complaint],
      severity: complaint.severity,
      kind: complaint.kind,
      details: complaint.details,
      location_attributes:
      { latitude: complaint.latitude, longitude: complaint.longitude }
    }
  end

  def generate_incident
    @incident = Incident.create!(build_attributes)
  end

  def update_complaint
    complaint.update!(incident: @incident)
  end
end
