# frozen_string_literal: true

class Report
  include ActiveModel::Validations
  # TODO: represents the actual report, validate data and implement report methods
  def self.get(employee_id, from_date, to_date)
    ReportGenerator.new.prepare_report(employee_id, from_date, to_date)
    # if employee_id.present? && from_date.present? && to_date.present?
    # else
    #   { code: 400 }
    # end
  end
end
