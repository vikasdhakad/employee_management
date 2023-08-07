# frozen_string_literal: true

class Event < ApplicationRecord
  # TODO: implement validations and kind of events
  enum kind: %w[in out]
  validates :employee_id, :timestamp, :kind, presence:true
  validates :kind, inclusion: { in: %w[in out] }
end
