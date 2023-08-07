# frozen_string_literal: true

class Report
  include ActiveModel::Validations
  # TODO: represents the actual report, validate data and implement report methods
  def self.get(employee_id, from_date, to_date)
    if employee_id.present? && validate_date?(from_date, to_date)  
      report = ReportGenerator.new.prepare_report(employee_id, from_date, to_date)
      { status: 200, body: report.to_json }
    else
      { status: 400 }
    end
  end

  def self.validate_date?(from_date, to_date)
    from_date = Date.strptime(from_date) rescue nil
    to_date = Date.strptime(to_date) rescue nil
    from_date.present? && to_date.present?
  end
end
